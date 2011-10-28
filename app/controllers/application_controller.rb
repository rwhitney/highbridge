class ApplicationController < ActionController::Base
  protect_from_forgery
  
protected
  authenticate_or_request_with_http_basic do |username, password|
    m = Member.validate_login username, password
    @user = m
    m != nil
  end
end
