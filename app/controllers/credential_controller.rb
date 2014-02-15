class CredentialController < ApplicationController
	require 'json'
	#PUT credential/:id
	def update
		params[:password]
		respond_to do |format|
  			format.json { render :json => "test" }
		end
	end
end
