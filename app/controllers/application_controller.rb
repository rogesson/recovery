class ApplicationController < ActionController::Base
  #[Desabled to use global session]
  #protect_from_forgery
  
  before_filter :_set_current_session, :verify_active_session

    def verify_active_session
    	if session[:user_id] == nil
    		redirect_to "/main"
    	end
    end

    protected
    def _set_current_session
      accessor = instance_variable_get(:@_request)
      ActiveRecord::Base.send(:define_method, "session", proc {accessor.session})
    end
end
