class CredentialController < ApplicationController
	require 'json'
	#PUT credential/:id
	def update
		
		credential = Credential.find(params[:id])
		credential.password = params[:password]
		credential.save
	end

	#DELETE credential/:id
	def destroy
		credential = Credential.find(params[:id]).delete
	end
end
