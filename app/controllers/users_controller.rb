class UsersController < ApplicationController
	skip_before_filter :verify_active_session, only: [:new, :create]

	def create
	 	flash = 
	 		if user = User.create(params[:user])
				{ 
					:flash => { :notice => 'User createad!' } 
				}
			else
				{ 
					:flash => { :errors => user.errors }
				}
			end

		redirect_to main_index_path, flash
	end

	# TODO refatorar  #teste criado
	def show
		@user = User.find(params[:id])
	end

	# TODO refatorar   
	def edit
		@user = User.find(session[:user_id])
	end

	# TODO refatorar   #teste criado
	def index
		@users = User.where("id != ?", session[:user_id])
	end

	def new
		@user = User.new
	end
end