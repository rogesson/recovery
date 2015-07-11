class CredentialsController < ApplicationController
	before_filter :set_user
	before_filter :set_credential, only: [:update, :destroy, :show]

	def index
		@credentials_result = params[:term] ? Credential.search(params) : @user.credential
	end

	def new
		@credential = Credential.new
	end

	def create
		credential = @user.credential.new(params[:credential])
		response = credential.save ? 'success' : credential.errors

		render js: { response: response }
	end

	def show
		render layout: false

		@credential
	end

	def update 
		response = @credential.update_attributes(params[:credential]) ? 'success' : @credential.errors

		render json: { response: response }
	end

	def destroy
		response = @credential.destroy ? 'success' : @credential.errors

		render json: { response: response }
	end

	private

	def set_user
		@user = User.where(id: session[:user_id]).first
	end

	def set_credential
		@credential = @user.credential.where(id: params[:id]).first
	end
end
