class CredentialsController < ApplicationController
	before_filter :set_user
	before_filter :set_credential, only: [:update, :destroy, :show]

	def index
		@credentials_result = params[:term] ? Credential.search(params) : @user.credential
	end

	def new
		@credential = Credential.new

		render layout: false
	end

	def create
		@new_credential = @user.credential.new(params[:credential])
		@response = @new_credential.save ? 'success' : @new_credential.errors

		respond_to :js
	end

	def show
		render layout: false

		@credential
	end

	def update
		@response = @credential.update_attributes(credential_params) ? 'success' : @credential.errors

		respond_to :js
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

	def credential_params
		params.require(:credential).permit(:password)
	end
end
