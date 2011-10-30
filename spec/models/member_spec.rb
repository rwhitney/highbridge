require 'spec_helper'
require 'spec_constants_helper'

describe Member do
  describe "Create member" do
    it "creates a new member" do
      Member.create!(russ_attributes)
    end
    
    it "creates encoded password correctly" do
      m1 = Member.create!(russ_attributes)
      Member.validate_login "russw08", "explorer"
    end
    
    it "validates email correctly" do
      m1 = Member.new(russ_attributes)
      m1.encode_password!
      m1.should be_valid
      m1.oldemail = "fred"
      m1.should_not be_valid
      m1.oldemail = "fred.com"
      m1.should_not be_valid
      m1.oldemail = "fred@fred.com"
      m1.should be_valid
      m1.oldemail = nil
      m1.should_not be_valid
    end
    
    it "validates uniqueness" do
      m1 = Member.new(russ_attributes)
      m1.encode_password!
      m1.should be_valid
      m2 = Member.new(lisa_attributes)
      m2.encode_password!
      m2.should be_valid

      russ = Member.create!(russ_attributes)
      
      m1.should_not be_valid
      m2.should be_valid
      
      lisa = Member.create!(lisa_attributes)
      
      m1.should_not be_valid
      m2.should_not be_valid
    end
  end
end
