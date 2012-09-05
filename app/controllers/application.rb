# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require_dependency "login_system"

class ApplicationController < ActionController::Base
	
  include LoginSystem 
 # model :user
  
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_cvicebnice2.0_session_id'
end
