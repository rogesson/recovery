class CredentialController < ApplicationController
	require 'json'
	#PUT credential/:id
	def update
		
		credential = Credential.find(params[:id])
		credential.password = params[:password]
		credential.save

		respond_to do |format|
  			format.json { render :json => "test" }
		end
	end
end
