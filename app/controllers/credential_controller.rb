class CredentialController < ApplicationController
	require 'json'
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
		
		if Credential.find(params[:id]).delete
			@response = "Deleted!"
		else
			@response = "Try Again"
		end

		
		render :js => "alert('#{@response}'); window.location.reload();"
	end
end
