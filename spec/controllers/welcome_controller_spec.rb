require 'spec_helper'

describe WelcomeController do
  render_views
  
  before(:each) do
    @base_title = "Mores Creek Ambulance"
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'index'
      response.should have_selector("title",
        :content => @base_title)
    end
    
  end

  describe "GET 'generalinfo'" do
    it "returns http success" do
      get 'generalinfo'
      response.should be_success
    end

    it "should have the right title" do
      get 'generalinfo'
      response.should have_selector("title",
        :content => @base_title + " | General Info")
    end
  end

  describe "GET 'volunteerinfo'" do
    it "returns http success" do
      get 'volunteerinfo'
      response.should be_success
    end

    it "should have the right title" do
      get 'volunteerinfo'
      response.should have_selector("title",
        :content => @base_title + " | Volunteer Info")
    end
  end

  describe "GET 'links'" do
    it "returns http success" do
      get 'links'
      response.should be_success
    end

    it "should have the right title" do
      get 'links'
      response.should have_selector("title",
        :content => @base_title + " | Links")
    end
  end

  describe "GET 'memberapp'" do
    it "returns http success" do
      get 'memberapp'
      response.should be_success
    end

    it "returns a document of type pdf" do
      get 'memberapp'
      response.headers['Content-Type'].should == "application/pdf"
      response.headers['Content-Disposition'].should == 'attachment; filename="App-Membership-Application.pdf"'
    end
  end

  describe "GET 'brochure'" do
    it "returns http success" do
      get 'brochure'
      response.should be_success
    end

    it "returns a document of type pdf" do
      get 'brochure'
      response.headers['Content-Type'].should == "application/pdf"
      response.headers['Content-Disposition'].should == 'attachment; filename="MCABrochure.pdf"'
    end
  end

  describe "GET 'lifeflight'" do
    it "returns http success" do
      get 'lifeflight'
      response.should be_success
    end

    it "returns an image of type jpg" do
      get 'lifeflight'
      response.headers['Content-Type'].should == "image/jpg"
      response.headers['Content-Disposition'].should == 'inline; filename="lifeflight.jpg"'
    end
  end

end
