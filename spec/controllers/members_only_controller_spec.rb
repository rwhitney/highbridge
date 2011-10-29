require 'spec_helper'

describe MembersOnlyController do
  render_views
  
  before(:each) do
    @base_title = "Mores Creek Members Only"
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    
    it "has the correct title" do
      get 'index'
      response.should have_selector("title",
        :content => @base_title)
    end
  end

end
