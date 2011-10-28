require 'spec_helper'

describe "shifts/index.html.erb" do
  before(:each) do
    assign(:shifts, [
      stub_model(Shift,
        :shiftnum => 1,
        :e1member_id => 1,
        :e2member_id => 1,
        :dmember_id => 1
      ),
      stub_model(Shift,
        :shiftnum => 1,
        :e1member_id => 1,
        :e2member_id => 1,
        :dmember_id => 1
      )
    ])
  end

  it "renders a list of shifts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
