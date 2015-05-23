class CredentialsController < ApplicationController
	
	def new
		@credential = Credential.new
	end

	def create
		credential = Credential.new(params[:credential].except(:password, :user_id))

		credential.password = DigestManager.enc(params[:credential][:password], session[:c_key])
		credential.user_id  = session[:user_id]
		
		if credential.save
			response = "/credentials/list"
		else
			response = credential.errors.full_messages[0] ||= "Credential Created!"
		end
		
		redirect_to response
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

end
