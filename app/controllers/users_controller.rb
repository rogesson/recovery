class UsersController < ApplicationController
	skip_before_filter :verify_active_session, only: [:new, :create]

	# TODO refatorar
	def create
		user = User.new(
			:login 	  => params[:login],
		 	:password => Digest::SHA256.hexdigest(params[:password]).reverse[5..-1],
		 	:email    => params[:email]
		)

		if user.save
			notice = "User created!"
		else
			notice = user.errors.full_messages[0]
		end

		redirect_to :back, :flash => {:notice => notice}
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