class CredentialsController < ApplicationController
	before_filter :enc_password, only: [:create]
	before_filter :set_user
	before_filter :set_credential, only: [:update, :destroy, :show]
	
	def index
		@credentials = @user.credential
	end

	def new
		@credential = Credential.new
	end

	def create
		credential = @user.credential.new(params[:credential])
		response = credential.save ? 'success' : credential.errors

		render js: { response: response }
	end

	def update 
		response = @credential.update_attributes(params[:credential]) ? 'success' : @credential.errors

		render json: { response: response }
	end

	def destroy
		response = @credential.destroy ? 'success' : @credential.errors

		render json: { response: response }
	end

	# TODO refatorar
	def list
		credentials = @user.credential
		search_credential = credentials.search_by(type: params[:type], search: params[:search])
		default = true if params[:type] == "0" || params[:type].nil?

		@credentials = default ? credentials : search_credential
	end

	def show
		render layout: false

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
