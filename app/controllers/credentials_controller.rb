class CredentialsController < ApplicationController
	
	def create
		credential = Credential.new(
			:login    => params[:login],
			:password => digest_secure.enc(params[:password]),
			:site     => params[:site],
			:user_id  => session[:user_id]
		)

		credential.save
		
		response = credential.errors.full_messages[0] ||= "Credential Created!"
	
		render js: %W{responseForm("#{response}")}
	end


	#PUT credential/:id
	def update
		credential = Credential.find(params[:id]).taint

		if credential.change_password digest_secure.enc(params[:password])
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
	  		@passwords = Credential.where("user_id = ?", session[:user_id])
	  	end
	end

	private
	def digest_secure
		Gibberish::AES.new(session[:c_key])
	end
end
