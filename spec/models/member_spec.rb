require 'spec_helper'

describe Member do
  describe "Create member" do
    it "creates a user correctly" do
      m1 = FactoryGirl.create(:member)
    end
    
    it "creates an admin correctly" do
      m1 = FactoryGirl.create(:admin)
    end
    
    it "validates email correctly" do
      m1 = FactoryGirl.build(:russ)
      m1.should be_valid
      m1.email = "fred"
      m1.should_not be_valid
      m1.email = "fred.com"
      m1.should_not be_valid
      m1.email = "fred@fred.com"
      m1.should be_valid
      m1.email = nil
      m1.should_not be_valid
    end
    
    it "validates uniqueness" do
      m1 = FactoryGirl.build(:russ)
      m1.should be_valid
      m2 = FactoryGirl.build(:lisa)
      m2.should be_valid

      russ = FactoryGirl.create(:russ)
      
      m1.should_not be_valid
      m2.should be_valid
      
      lisa = FactoryGirl.create(:lisa)
      
      m1.should_not be_valid
      m2.should_not be_valid
    end
  end
end
