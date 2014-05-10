class MainController < ApplicationController
	skip_before_filter :verify_active_session

	def index

	end
end
