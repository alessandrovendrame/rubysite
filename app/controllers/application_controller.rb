# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def trace( description )
    current_user.log_entries.create!(
      :ip => request.remote_ip,
      :description => description
    )
  end
  
  def is_admin?
    unless current_user.admin?
      raise "Not allowed to see this action"
    end
  end

  def authorize_user
    if user_signed_in? && !current_user.authorized_to_see_action?(controller_name, action_name)
      raise 'Not allowed to see this action'
    end
  end

end
