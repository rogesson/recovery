class CredentialController < ApplicationController
	
	#PUT credential/:id
	def update
		credential = Credential.find(params[:id]).taint

		if credential.change_password params[:password]
			@response = {:response => 200}
		else
			@response = {:response => 500}
		end

		
		#render :json => @response.to_json

		respond_to do |format|
 			format.json { render :json => "qweqwe" }
		end
	end

	#DELETE credential/:id
	def destroy
		credential = Credential.find(params[:id]).delete
	end
end
