require 'spec_helper'

describe Shift do
  before(:each) do
    @russ = FactoryGirl.create(:russ)
    @lisa = FactoryGirl.create(:lisa)
    @paul = FactoryGirl.create(:paul)
    @drew = FactoryGirl.create(:drew)
    @dennis = FactoryGirl.create(:dennis)
  end
  
  describe "Create Shift" do
    it "creates a new shift" do
      FactoryGirl.create(:shift1, :e1member_id => @dennis.id, :dmember_id => @russ.id)
    end
    
    it "validates at least one member" do
      s = FactoryGirl.build(:shift2)
      s.should_not be_valid
    end
  end
end
