class CredentialsController < ApplicationController
	

	def create
		credential = Credential.new(
			:login    => params[:login],
			:password => params[:password],
			:site     => params[:site],
			:user_id  => session[:user_id]
		)

		credential.save
		
		@error_credential = credential.errors.full_messages[0]
		redirect_to :back, :flash => {:notice => @error_credential}
	end


	#PUT credential/:id
	def update
		credential = Credential.find(params[:id]).taint

		if credential.change_password params[:password]
			@response = {:message => "Password Changed!", code: 200}
		else
			@response = {:message => "Password not changed", code: 500}
		end

		
		#render :js => "alert('#{@response}');"
		render :json => @response.to_json
	end

	#DELETE credential/:id
	def destroy
		credenetial = Credential.find(params[:id])
		if credenetial.safe_delete 
			@response = {:message => "success", code: 200}
		else
			response = {:message => "error", code: 500}
		end

		render :json => @response.to_json
	end
end
