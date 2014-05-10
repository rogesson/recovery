class MainController < ApplicationController
	skip_before_filter :verify_active_session

	def index

	end


	def logout
		session.delete :session_id 
		session.delete :user_id
		redirect_to '/main?'
	end
end
