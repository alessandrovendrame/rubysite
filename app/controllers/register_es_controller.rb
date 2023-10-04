class RegisterEsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :authorize_user
  
  def index
    conditions = ["1 = 1"] # all
    
    @month = params[:date][:month] unless params[:date].blank?
    unless @month.blank?
      conditions[0] << " AND MONTH(date) = ? AND YEAR(date) = ?"
      conditions << @month
      conditions << Date.today.year
    else
      unless params[:from].blank?
        conditions[0] << " AND date >= ?"
        date = Date.strptime(params[:from], '%d/%m/%Y').to_date rescue ""
        conditions << date
      end

      unless params[:to].blank?
        conditions[0] << " AND date <= ?"
        date = Date.strptime(params[:to], '%d/%m/%Y').to_date rescue ""
        conditions << date
      end
    end
    
    unless params[:plate].blank?
      conditions[0] << " AND plate_number like ? "
      conditions << "%#{params[:plate]}%"
    end
    
    unless params[:container].blank?
      conditions[0] << " AND container like ? "
      conditions << "%#{params[:container]}%"
    end
    
    unless params[:sender].blank?
      conditions[0] << " AND sender_id = ?"
      conditions << params[:sender].to_i
    end
    
    unless params[:recipient].blank?
      conditions[0] << " AND recipient_id = ?"
      conditions << params[:recipient].to_i
    end
    
    unless params[:carrier].blank?
      conditions[0] << " AND carrier_id = ?"
      conditions << params[:carrier].to_i
    end

    unless params[:vendor].blank?
      conditions[0] << " AND vendor_id = ?"
      conditions << params[:vendor].to_i
    end

    conditions.size > 1 ? @filtered = true : @filtered = false
    
    @registers = RegisterE.all.where(conditions).ordered

    @nole_cost = @registers.inject(0){|x,r| x+r.nole_cost}
    @bl_cost = @registers.inject(0){|x,r| x+r.bl_cost}
    @transport_cost = @registers.inject(0){|x,r| x+r.transport_cost}
    @stop_cost = @registers.inject(0){|x,r| x+r.stop_cost}
    @incidental_cost = @registers.inject(0){|x,r| x+r.incidental_cost}
    @net = @registers.inject(0){|x,r| x+r.net}
    @gross = @registers.inject(0){|x,r| x+r.gross}
    
    @registers = @registers.paginate :per_page => 20, :page => params[:page]
                    
    @name = RegisterE::NAME
  end
  
  def index____old
    @registers = RegisterE.find(:all, :order => "lpad(code, 10, ' ') DESC").paginate :per_page => 20, :page => params[:page]
    @name = RegisterE::NAME
  end

  def show
    @register = RegisterE.find(params[:id])
  end

  def new
    new_code = RegisterE.where("date >= '#{Date.today.year}-01-1'").last.code.to_i + 1 rescue 1
    @register = RegisterE.new({code: new_code})
    @name = RegisterE::NAME
  end
  
  def create
    @register = RegisterE.new(register_e_params)
    @register.save!
    trace("Creazione voce #{@register.class::NAME} - ##{@register.id}")
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def edit
    @register = RegisterE.find(params[:id])
  end
  
  def update
    @register = RegisterE.find(params[:id])
    @register.update_attributes!(register_e_params)
    trace("Aggiornamento voce #{@register.class::NAME} - ##{@register.id}")
    unless params[:redirect].blank?
      redirect_to params[:redirect]
    else
      redirect_to :action => :index
    end
    
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @register = RegisterE.find(params[:id])
    @register.destroy
    trace("Eliminazione voce #{@register.class::NAME} - ##{@register.id}")
    redirect_to :action => :index
  end
  
private

  def register_e_params
    params.require(:register_e).permit("code", "date(1i)", "date(2i)", "date(3i)", "sender_id", "new_sender_name", "vendor_id", "new_vendor_name", "recipient_id", "new_recipient_name", "carrier_id", "new_carrier_name", "plate_number", "weight", "packages", "container", "nole_cost", "bl_cost", "transport_cost", "stop_cost", "incidental_cost", "net", "notes")
  end  
end
