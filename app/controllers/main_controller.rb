class MainController < ApplicationController
	skip_before_filter :verify_active_session, only: :index

	def index
    @user = User.new
    @session = Session.new
    
		render layout: false
	end

  def home;end
end
