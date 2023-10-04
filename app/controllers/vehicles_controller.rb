class VehiclesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, :only => [:lookup]
  
  before_action :authenticate_user!
  before_action :is_admin?
  
  def index
    @vehicles = Vehicle.all.order("name ASC").paginate :per_page => 20, :page => params[:page]
  end
  
  def show
    @vehicle = Vehicle.find(params[:id])
  end
  
  def new
    @vehicle = Vehicle.new
  end
  
  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.save!
    redirect_to vehicles_path
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
  
  def edit
    @vehicle = Vehicle.find(params[:id])
  end
  
  def update
    @vehicle = Vehicle.find(params[:id])
    @vehicle.update_attributes!(vehicle_params)
    redirect_to vehicles_path
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end
  
  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy
    redirect_to vehicles_path
  end
  
  def lookup
    @vehicles = Vehicle.where("name like ?", "%#{params[:name]}%")
    render :inline => "<%= auto_complete_result @vehicles, 'name' %>"
  end

private

  def vehicle_params
    params.require(:vehicle).permit("name", "sender", "recipient", "carrier", "vendor", "register_a", "register_b", "register_c", "register_d", "register_e")
  end
end
