class DeviseSessionsController < Devise::SessionsController
  layout "application_nav_bar"

  def create
    redirect_to user_omniauth_authorize_path(:google_oauth2)
  end

  def new
    redirect_to user_omniauth_authorize_path(:google_oauth2)
  end

end
