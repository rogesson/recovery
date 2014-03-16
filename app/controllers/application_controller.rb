class ApplicationController < ActionController::Base
  protect_from_forgery

  def verify_active_session
  	if session[:user_id] == nil
  		redirect_to "/main"
  	end
  end
end
