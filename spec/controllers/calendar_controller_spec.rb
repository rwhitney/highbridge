require 'spec_helper'

describe CalendarController do
  login_user

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'shiftedit'" do
    it "returns http success" do
      get 'shiftedit', :date => Date.today
      response.should be_success
    end
  end

  describe "POST 'shiftsignup'" do
    it "successfully redirects" do
      post "shiftsignup", :received => Date.today, :shiftdate => Date.today, :position => 'D, 1'
      
      response.should redirect_to :action => :index, :thedate => Date.today
    end
  end

end
