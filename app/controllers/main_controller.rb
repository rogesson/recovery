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

	end
end
