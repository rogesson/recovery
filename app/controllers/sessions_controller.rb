class SessionsController < ApplicationController
	skip_before_filter :verify_active_session

	# TODO refatorar
	def create
		user = User.where(:login => params[:login], :password => encoded_password).first

		if user
			#create session
			session[:session_id] = Random.rand(19999283)
			session[:user_id]    = user.id
			session[:c_key]      = generate_c_key

			redirect_to "/home"
		else
			redirect_to '/main', :flash => {:bad_login => "invalid login"}
		end
	end

	# TODO refatorar
	def logout
		session.delete :session_id 
		session.delete :user_id
		session.delete :c_key

		redirect_to '/main'
	end

	private

	def generate_c_key
		safe_credential = "#{params[:password]}#{params[:login]}^]+^@".reverse[1..-1]
		safe_credential = Digest::SHA256.hexdigest safe_credential
	end

	def encoded_password
		Digest::SHA256.hexdigest(params[:password]).reverse[5..-1]
	end
end
