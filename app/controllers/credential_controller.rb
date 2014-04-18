class CredentialController < ApplicationController
	require 'json'
	#PUT credential/:id
	def update
		credential = Credential.find(params[:id])
		credential.password = params[:password]
		if credential.save
			@response = {:response => 200}
		else
			@response = {:response => 500}
		end

		respond_to do |format|
		 format.js { render "alert('asodkaoskdoaksd!')" }
		end
	end

	#DELETE credential/:id
	def destroy
		credential = Credential.find(params[:id]).delete
	end
end
