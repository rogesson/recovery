class MessagesController < ApplicationController
	def new
		@recipient = User.find(params[:to])
		@message = Message.new
	end

	def create 

	end
end