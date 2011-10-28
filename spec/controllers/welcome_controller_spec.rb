require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'generalinfo'" do
    it "returns http success" do
      get 'generalinfo'
      response.should be_success
    end
  end

  describe "GET 'volunteerinfo'" do
    it "returns http success" do
      get 'volunteerinfo'
      response.should be_success
    end
  end

  describe "GET 'links'" do
    it "returns http success" do
      get 'links'
      response.should be_success
    end
  end

end
