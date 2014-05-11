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
			@response = "Password Changed!"
		else
			@response = "Password not changed, try again."
		end

		
		render :js => "alert('#{@response}');"
	end

	#DELETE credential/:id
	def destroy
		credenetial = Credential.find(params[:id])
		if credenetial.safe_delete 
			@response = "Deleted!"
		else
			@response = "Try Again"
		end

		
		render :js => "alert('#{@response}'); window.location.reload();"
	end
end
