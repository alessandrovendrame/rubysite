class RegisterAsController < ApplicationController

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
    
    conditions.size > 1 ? @filtered = true : @filtered = false
    
    @registers = RegisterA.all.where(conditions).ordered

    @total_cost = @registers.inject(0){|x,r| x+r.cost}
    @total_net_stock = @registers.inject(0){|x,r| x+r.net_stock}
    @total_net_customs = @registers.inject(0){|x,r| x+r.net_customs}
    @total_net_transport = @registers.inject(0){|x,r| x+r.net_transport}
    @total_gross = @registers.inject(0){|x,r| x+r.gross}
    
    @registers = @registers.paginate :per_page => 20, :page => params[:page]
                    
    @name = RegisterA::NAME
  end

  def show
    @register = RegisterA.find(params[:id])
  end
  
  
  def new
    new_code = RegisterA.where("date >= '#{Date.today.year}-01-1'").last.code.to_i + 1 rescue 1
    @register = RegisterA.new({code: new_code})
    @name = RegisterA::NAME

  end
  
  def create
    @register = RegisterA.new(register_a_params)
    @register.save!
    trace("Creazione voce #{@register.class::NAME} - ##{@register.id}")
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def edit
    @register = RegisterA.find(params[:id])
  end
  
  def update
    @register = RegisterA.find(params[:id])
    @register.update_attributes!(register_a_params)
    trace("Aggiornamento registro #{@register.class::NAME} - ##{@register.id}")
    unless params[:redirect].blank?
      redirect_to params[:redirect]
    else
      redirect_to :action => :index
    end
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @register = RegisterA.find(params[:id])
    @register.destroy
    trace("Eliminazione registro #{@register.class::NAME} - ##{@register.id}")
    redirect_to :action => :index
  end

private

  def register_a_params
    params.require(:register_a).permit("code", "date(1i)", "date(2i)", "date(3i)", "sender_id", "new_sender_name", "recipient_id", "new_recipient_name", "carrier_id", "new_carrier_name", "plate_number", "customs", "cost", "net_stock", "net_customs", "net_transport", "notes")
  end
  
end
