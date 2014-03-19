class MainController < ApplicationController
	require 'json'

	def index


	end

	def create
		if params[:password_conf] == params[:password]
			User.create(
				:login => params[:login],
			 	:password => Digest::SHA256.hexdigest(params[:password]),
			 	:email => params[:email]
			 	)
		else
			redirect_to :back			
		end
	end

	def home_page
		user = User.where(:login => params[:login], :password => Digest::SHA256.hexdigest(params[:password]))
		if  user != []

			session[:session_id] = Random.rand(19999283)
			session[:user_id] = user[0].id

			redirect_to "/user/#{user[0].id}"
		else
			redirect_to '/main?bad_login=1'
		end
	end

	def new_password
		Credential.create(:login => params[:login],
		 :password => params[:password],
		 :site => params[:site],
		 :user_id => session[:user_id]
		 )
		redirect_to :back
	end

	def logout
		session.delete :session_id 
		session.delete :user_id
		redirect_to '/main?'
	end
end
