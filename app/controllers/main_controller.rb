class MainController < ApplicationController
	require 'json'
	def index


	end

	def create
		if params[:password_conf] == params[:password]
			User.create(
				:login => params[:login],
			 	:password => params[:password],
			 	:email => params[:email]
			 	)
		else
			redirect_to :back			
		end
	end

	def home_page
		if User.where(:login => params[:login], :password => params[:password]) != []
			
		else
			redirect_to '/main?bad_login=1'
		end

	end

	def new_password
		Credential.create(:login => params[:login],
		 :password => params[:password],
		 :site => params[:site],
		 :user_id => 1
		 )

		redirect_to '/main/1/home_page'
	end
end
