class ApplicationController < ActionController::Base
  protect_from_forgery
  # disable implicit helper(:all) in rails3
  # by default all helpers are included into all views
  # this changes it so only the helper with the same name is available
  clear_helpers

end
