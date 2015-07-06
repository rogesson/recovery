class UsersController < ApplicationController
	skip_before_filter :verify_active_session, only: [:new, :create]

	def create
	 	flash = 
	 		if user = User.create(params[:user])
				{ :notice => 'User createad!' } 
			else
				{ :errors => user.errors }
			end

		redirect_to main_index_path, flash: flash
	end

	def show
		@user = User.find(params[:id])
	end
  
	def edit
		@user = User.find(session[:user_id])
	end

	def index
		@users = User.where("id != ?", session[:user_id])
	end

	def new
		@user = User.new
	end

	def update
		user = User.find(session[:user_id])

		response = 
	 		if user.update_attributes(params[:user])
					{ response: 'success' }
			else
					{ response: 'erro', errors: user.errors }
			end

			render js: response
	end
end