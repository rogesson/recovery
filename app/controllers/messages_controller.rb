class MessagesController < ApplicationController
	def new
		@recipient = User.find(params[:to])
		@message = Message.new
	end

	def create 
		@message = Message.new
		@message.subject   = params[:message][:subject]
		@message.body      = params[:message][:body]
		@message.recipient = User.find(2)
		@message.sender    = User.find(session[:user_id])


		if @message.save
			redirect_to @message
		end
	end
end