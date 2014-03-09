class ApplicationController < ActionController::Base
  protect_from_forgery

  def verify_active_session
  	 #redirect_to "/main"
  end
end
