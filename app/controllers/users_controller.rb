class UsersController < ApplicationController
	skip_before_filter :verify_active_session, only: [:new, :create]

	def create
	 	response = 
	 		if user = User.create(params[:user])
				'success'
			else
				user.errors
			end

		render js: { response: response }
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
				'success'
			else
				user.errors
			end

			render js: { response: response }
	end
end