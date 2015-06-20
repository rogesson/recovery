class CredentialsController < ApplicationController
	before_filter :enc_password, only: [:create]
	before_filter :set_user
	before_filter :set_credential, only: [:update, :destroy, :show]
	
	def new
		@credential = Credential.new
	end

	def create
		if @user.credential.create(params[:credential])
			redirect_to list_credentials_path
		else
			redirect_to :back
		end
	end

	def update
		response = 
			if params[:password].present? and @credential.change_password(DigestManager.enc(params[:password], session[:c_key]))
				response = 'success'
			else
				response = 'error'
			end

		render json: { response: response }
	end

	# TODO refatorar
	def destroy
		credenetial = Credential.find(params[:id])
		if credenetial.safe_delete 
			response = {:message => "success", code: 200}
		else
			response = {:message => "error", code: 500}
		end

		render :json => response.to_json
	end

	# TODO refatorar
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
		render :status => 404
				
		@credential
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

	def set_credential
		@credential = @user.credential.where(id: params[:id]).first

		render :text => 'Not Found', :status => '404' unless @credential
	end

end
