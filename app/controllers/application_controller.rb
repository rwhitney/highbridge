class ApplicationController < ActionController::Base
  protect_from_forgery
  # disable implicit helper(:all) in rails3
  # by default all helpers are included into all views
  # this changes it so only the helper with the same name is available
  clear_helpers

  def render_forbidden
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false }
      format.json { render :json => { :error => true, :message => "Error 403, you don't have permissions for this operation." } }
    end
  end
  
  def utc_string(fortime = Time.now)
    fortime.utc.strftime("%a, %d %b %Y %H:%M:%S GMT")
  end
  
  def utc_string_15min
    utc_string(Time.now + 15.minutes)
  end
end
