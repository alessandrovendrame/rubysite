class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    welcome_page =  "register_es" if current_user.authorized_to_see_action?("register_es", "index")
    welcome_page =  "register_ds" if current_user.authorized_to_see_action?("register_ds", "index")
    welcome_page =  "register_cs" if current_user.authorized_to_see_action?("register_cs", "index")
    welcome_page =  "register_bs" if current_user.authorized_to_see_action?("register_bs", "index")
    welcome_page =  "register_as" if current_user.authorized_to_see_action?("register_as", "index")
    redirect_to :controller => welcome_page
  end

end
