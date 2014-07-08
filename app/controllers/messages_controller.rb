class MessagesController < ApplicationController
	def new
		@recipient = User.find(params[:to])
		@message = Message.new
	end

	def create 
		@message = Message.new
		@message.subject   = params[:message][:subject]
		@message.body      = params[:message][:body]
		@message.recipient = User.find(params[:message][:recipient])
		@message.sender    = User.find(session[:user_id])


		if @message.save
			redirect_to @message
		end
	end

	def show
		@message = Message.find(params[:id])

		if @message.sender_id == session[:user_id] or @message.recipient_id == session[:user_id]
			Message.read_message(@message.id, User.find(session[:user_id])) if @message.recipient_id == session[:user_id]
			@message
		else
			redirect_to :back
		end
	end

	def index
		user = User.find(session[:user_id])
		@received_messages = user.received_messages
	end

	def destroy
		message = Message.find(params[:id])

		message.destroy if message.recipient_id == session[:user_id]
		redirect_to "/messages"
	end

	def verify_new_msg

		user = User.find(session[:user_id])
		unread_count = user.unread_message_count if user.unread_message_count > 0
		if unread_count
			response = {:news => unread_count }
		else
			response = {:news => 0 }
		end
		

		render :json => response.to_json
	end
end