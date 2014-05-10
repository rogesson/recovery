class MainController < ApplicationController
	skip_before_filter :verify_active_session

	def index

	end

	def create
		if params[:password_conf] == params[:password]
			User.create(
				:login 	  => params[:login],
			 	:password => Digest::SHA256.hexdigest(params[:password]),
			 	:email    => params[:email]
			)
		else
			redirect_to :back			
		end
	end

	def logout
		session.delete :session_id 
		session.delete :user_id
		redirect_to '/main?'
	end
end
