class CredentialsController < ApplicationController
	before_filter :enc_password, only: [:create]
	before_filter :set_user
	
	def new
		@credential = Credential.new
	end

	def create
		if @user.credential.create(params[:credential])
			redirect_to list_credentials_path
			#response = "/credentials/list"
		else
			redirect_to :back, flash: credential.errors.full_messages.first
		end
	end


	#PUT credential/:id
	def update
		credential = Credential.find(params[:id]).taint

		if credential.change_password(DigestManager.enc(params[:password], session[:c_key]))
			response = {:message => "Password Changed!", code: 200}
		else
			response = {:message => "Password not changed", code: 500}
		end

		render :json => response.to_json
	end

	#DELETE credential/:id
	def destroy
		credenetial = Credential.find(params[:id])
		if credenetial.safe_delete 
			response = {:message => "success", code: 200}
		else
			response = {:message => "error", code: 500}
		end

		render :json => response.to_json
	end

	def list
		if params[:type] == "1"
	  		#type 1 is search by site name
	  		@passwords = Credential.where("user_id = ? AND site LIKE ?", session[:user_id], "%#{params[:search]}%")
  		elsif params[:type] == "2"
  			#type 2 is search by login
  			@passwords = Credential.where("user_id = ? AND login LIKE ?", session[:user_id], "%#{params[:search]}%")
	  	else
	  		@passwords = Credential.where(user_id: session[:user_id])
	  	end
	end

	def show
		render layout: false
		@credential = Credential.where(id: params[:id], user_id: session[:user_id]).first
		
		redirect_to @credential ||= "/"
	end

	private

	def enc_password
		return if params[:credential][:password].blank?

		params[:credential][:password] = 
			DigestManager.enc(params[:credential][:password], session[:c_key]) 
	end

	def set_user
		@user = User.where(id: session[:user_id]).first
	end

end
