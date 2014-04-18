class CredentialController < ApplicationController
	require 'json'
	#PUT credential/:id
	def update
		credential = Credential.find(params[:id]).taint
		 
		if credential.change_password params[:password]
			@response = {:response => 200}
		else
			@response = {:response => 500}
		end

		render :json => @response.to_json
	end

	#DELETE credential/:id
	def destroy
		credential = Credential.find(params[:id]).delete
	end
end
