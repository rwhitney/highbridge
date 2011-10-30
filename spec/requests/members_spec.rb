require 'spec_helper'

describe "Members" do
  # before(:each) do
  #   @request.env["devise.mapping"] = Devise.mappings[:admin]
  #   @current_user = FactoryGirl.create(:admin) # Using factory girl as an example
  #   sign_in @current_user
  # end
  
  describe "GET /members" do
  
    it "should redirect to login" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get members_path
      response.should redirect_to "/d/members/sign_in"
    end
  end
end
