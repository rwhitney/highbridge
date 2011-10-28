require 'spec_helper'

describe "shifts/edit.html.erb" do
  before(:each) do
    @shift = assign(:shift, stub_model(Shift,
      :shiftnum => 1,
      :e1member_id => 1,
      :e2member_id => 1,
      :dmember_id => 1
    ))
  end

  it "renders the edit shift form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => shifts_path(@shift), :method => "post" do
      assert_select "input#shift_shiftnum", :name => "shift[shiftnum]"
      assert_select "input#shift_e1member_id", :name => "shift[e1member_id]"
      assert_select "input#shift_e2member_id", :name => "shift[e2member_id]"
      assert_select "input#shift_dmember_id", :name => "shift[dmember_id]"
    end
  end
end
