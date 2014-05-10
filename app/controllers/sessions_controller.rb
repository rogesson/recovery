class SessionsController < ApplicationController
	skip_before_filter :verify_active_session

	def create
		user = User.where(
			:login 	  => params[:login],
			:password => Digest::SHA256.hexdigest(params[:password])
		)

		if  user != []

			session[:session_id] = Random.rand(19999283)
			session[:user_id] = user[0].id

			redirect_to "/user/#{user[0].id}"
		else
			redirect_to '/main?bad_login=1'
		end
	end
end
