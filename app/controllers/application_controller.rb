class ApplicationController < ActionController::Base
  protect_from_forgery
  
protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      m = Member.validate_login username, password
      @user = m
      # m != nil   <- shouldn't need this
    end
  end
end
