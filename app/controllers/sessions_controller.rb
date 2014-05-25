class SessionsController < ApplicationController
	skip_before_filter :verify_active_session
	before_filter      :generated_key, only: :create

	def create
		user = User.where(
			:login 	  => params[:login],
			:password => Digest::SHA256.hexdigest(params[:password]).reverse[5..-1]
		)

		if  user != []
			#create session
			session[:session_id] = Random.rand(19999283)
			session[:user_id] = user[0].id
			session[:c_key] = generated_key

			redirect_to "/users/#{user[0].id}"
		else
			redirect_to '/main', :flash => {:bad_login => "invalid login"}
		end
	end

	
	def logout
		session.delete :session_id 
		session.delete :user_id
		session.delete :c_key
		redirect_to '/main?'
	end

	private
	def generated_key
		safe_credential = "#{params[:password]}#{params[:login]}^]+^@".reverse[1..-1]
		safe_credential = Digest::SHA256.hexdigest safe_credential
	end 
end
