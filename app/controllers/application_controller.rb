class ApplicationController < ActionController::Base
  protect_from_forgery
  # disable implicit helper(:all) in rails3
  # by default all helpers are included into all views
  # this changes it so only the helper with the same name is available
  clear_helpers

protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      m = Member.validate_login username, password
      @user = m
      # m != nil   <- shouldn't need this
    end
  end
end
