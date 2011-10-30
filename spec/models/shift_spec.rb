require 'spec_helper'
require 'spec_constants_helper'

describe Shift do
  before(:each) do
    @russ = Member.create!(russ_attributes)
    @lisa = Member.create!(lisa_attributes)
    @paul = Member.create!(paul_attributes)
    @drew = Member.create!(drew_attributes)
    @dennis = Member.create!(dennis_attributes)
  end
  
  describe "Create Shift" do
    it "creates a new shift" do
      s = Shift.new
      s.e1 = @lisa
      s.driver = @russ
      s.shiftdate = Date.today
      s.shiftnum = 1
      s.save
    end
  end
end
