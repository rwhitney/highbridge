class MembersOnlyController < ApplicationController
  before_filter :authenticate_member!
  
  def index
    @title = "Home Page"
    @desc = "MCA members-only home page"
  end

end
