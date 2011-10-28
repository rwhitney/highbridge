require 'spec_helper'

describe CalendarController do

  describe "GET 'lionindex'" do
    it "returns http success" do
      get 'lionindex'
      response.should be_success
    end
  end

  describe "GET 'altindex'" do
    it "returns http success" do
      get 'altindex'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'shiftedit'" do
    it "returns http success" do
      get 'shiftedit'
      response.should be_success
    end
  end

  describe "GET 'shift_signup'" do
    it "returns http success" do
      get 'shift_signup'
      response.should be_success
    end
  end

  describe "GET 'shiftsignup'" do
    it "returns http success" do
      get 'shiftsignup'
      response.should be_success
    end
  end

end
