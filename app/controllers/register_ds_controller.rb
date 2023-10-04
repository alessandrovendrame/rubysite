class RegisterDsController < ApplicationController
  
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
    
    unless params[:sender].blank?
      conditions[0] << " AND sender_id = ?"
      conditions << params[:sender].to_i
    end
    
    unless params[:timeframe].blank?
      conditions[0] << " AND timeframe like ? "
      conditions << "%#{params[:timeframe]}%"
    end
    
    unless params[:type].blank?
      conditions[0] << " AND operation_type like ?"
      conditions << "%#{params[:type]}%"
    end
    
    unless params[:cadence].blank?
      conditions[0] << " AND cadence like  ?"
      conditions << "%#{params[:cadence]}%"
    end
    
    conditions.size > 1 ? @filtered = true : @filtered = false
    
    @registers = RegisterD.joins("LEFT JOIN vehicles AS senders ON senders.id = register_ds.sender_id").where(conditions).ordered

    @total_cost = @registers.inject(0){|x,r| x+r.cost}
    @total_net = @registers.inject(0){|x,r| x+r.net}
    @total_gross = @registers.inject(0){|x,r| x+r.gross}
    
    @registers = @registers.paginate :per_page => 20, :page => params[:page]
                    
    @name = RegisterD::NAME
  end
  
  def index____old
    @registers = RegisterD.find(:all, :order => "lpad(code, 10, ' ') DESC").paginate :per_page => 20, :page => params[:page]
    @name = RegisterD::NAME
  end

  def show
    @register = RegisterD.find(params[:id])
  end

  def new
    new_code = RegisterD.where("date >= '#{Date.today.year}-01-1'").last.code.to_i + 1 rescue 1
    @register = RegisterD.new({code: new_code})
    @name = RegisterD::NAME
  end
  
  def create
    @register = RegisterD.new(register_d_params)
    @register.save!
    trace("Creazione voce #{@register.class::NAME} - ##{@register.id}")
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def edit
    @register = RegisterD.find(params[:id])
  end
  
  def update
    @register = RegisterD.find(params[:id])
    @register.update_attributes!(register_d_params)
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
    @register = RegisterD.find(params[:id])
    @register.destroy
    trace("Eliminazione voce #{@register.class::NAME} - ##{@register.id}")
    redirect_to :action => :index
  end

private

  def register_d_params
    params.require(:register_d).permit("code", "date(1i)", "date(2i)", "date(3i)", "timeframe", "sender_id", "new_sender_name", "operation_type", "cadence", "cost", "net", "notes")
  end  
end
