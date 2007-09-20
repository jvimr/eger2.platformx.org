# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require_dependency "login_system"

class ApplicationController < ActionController::Base
	
  include LoginSystem 
 # model :user
  
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_cvicebnice2.0_session_id'
  
  #attr_reader :odkazy
    def initialize
      @odkazy = [ 
      ['FEK', 'http://webtodate.fek.zcu.cz/pages/Hlavni.htm'],
      ['KJA', 'http://webtodate.fek.zcu.cz/pages/katedry/KJA/index.htm'],
      ['Kontakt', 'mailto:ove@kja.zcu.cz'],
      ['CESNET', 'http://www.cesnet.cz/'],
      ['FRVŠ', 'http://www.frvs.cz/'],
      ['IIK Düsseldorf', 'http://www.iik-duesseldorf.de/'],
      ['Forum WD', 'http://www.wirtschaftsdeutsch.de/'],
      ['Lehrer Online', 'http://www.lehrer-online.de/index.htm']
      ]
    end
end
