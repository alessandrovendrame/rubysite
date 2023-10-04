class LogEntriesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :is_admin?
  
  def index
    @log_entries = LogEntry.find(:all, :order => 'created_at DESC').paginate(:include => :user, :page => params[:page], :per_page => 50)
  end
  
end
