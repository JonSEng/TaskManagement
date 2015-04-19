class WelcomeController < ApplicationController
  layout "application_nav_bar"
  def index
  	render 'index.html'
  end
end
