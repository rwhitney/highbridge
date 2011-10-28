require 'spec_helper'

describe "shifts/show.html.erb" do
  before(:each) do
    @shift = assign(:shift, stub_model(Shift,
      :shiftnum => 1,
      :e1member_id => 1,
      :e2member_id => 1,
      :dmember_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
