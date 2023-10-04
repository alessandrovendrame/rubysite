class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :is_admin?
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
    @roles = Role.all
  end
 
  def create
    @user = User.new(params[:user])
    
    if params[:roles]
      @user.role_ids = params[:roles].keys
    else
      @user.role_ids = []
    end
    
    @user.save!
    redirect_to users_path
  rescue ActiveRecord::RecordInvalid
    @roles = Role.all
    render :action => 'new'
  end
  
  def edit
    @user = User.find(params[:id])
    @roles = Role.all
  end
  
  def update
    @user = User.find(params[:id])
    
    if params[:roles]
      @user.role_ids = params[:roles].keys
    else
      @user.role_ids = []
    end
    
    @user.update_attributes!(params[:user])
    redirect_to users_path
  rescue ActiveRecord::RecordInvalid
    @roles = Role.all
    render :action => :edit
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  
end
