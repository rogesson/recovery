class UsersController < ApplicationController
	skip_before_filter :verify_active_session, only: :create
	before_filter      :digest_secure, only: :show
	before_filter      :safe_password, only: :create
	
	#post /users
	def create

		user = User.new(
			:login 	  => params[:login],
		 	:password => safe_password,
		 	:email    => params[:email]
		)

		if user.save
			notice = "User created!"
		else
			notice = user.errors.full_messages[0]
		end

		redirect_to :back, :flash => {:notice => notice}
	end

	#get /users/:id
	def show

		
		if params[:type] == "1"
	  		#type 1 is search by site name
	  		@passwords = Credential.where("user_id = ? AND site LIKE ?", session[:user_id], "%#{params[:search]}%")
  		
  		elsif params[:type] == "2"
  			#type 2 is search by login
  			@passwords = Credential.where("user_id = ? AND login LIKE ?", session[:user_id], "%#{params[:search]}%")
	  	else
	  		@passwords = Credential.where("user_id = ?", session[:user_id])
	  	end

	  	@passwords.each do |p|
	  		p.password = digest_secure.dec(p.password) 
	  	end
	  	
	end  
	private
	def digest_secure
		Gibberish::AES.new(session[:c_key])
	end

	def safe_password
		Digest::SHA256.hexdigest(params[:password]).reverse[5..-1]
	end


end