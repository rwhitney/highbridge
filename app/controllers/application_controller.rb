class ApplicationController < ActionController::Base
  protect_from_forgery
  # disable implicit helper(:all) in rails3
  # by default all helpers are included into all views
  # this changes it so only the helper with the same name is available
  clear_helpers

protected
  def old_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      if @user
        @user
      else
        @user = Member.validate_login username, password
      end
    end
  end
end
