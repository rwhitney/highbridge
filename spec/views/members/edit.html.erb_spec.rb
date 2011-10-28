require 'spec_helper'

describe "members/edit.html.erb" do
  before(:each) do
    @member = assign(:member, stub_model(Member,
      :fullname => "MyString",
      :portablename => "MyString",
      :portablenumber => 1,
      :email => "MyString",
      :privilege => "MyString",
      :streetaddress => "MyString",
      :city => "MyString",
      :zip => "MyString",
      :area => "MyString",
      :homephone => "MyString",
      :workphone => "MyString",
      :cellorotherphone => "MyString",
      :shirtsize => "MyString",
      :status => "MyString",
      :miscnotes => "MyString",
      :password => "MyString",
      :salt => "MyString"
    ))
  end

  it "renders the edit member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => members_path(@member), :method => "post" do
      assert_select "input#member_fullname", :name => "member[fullname]"
      assert_select "input#member_portablename", :name => "member[portablename]"
      assert_select "input#member_portablenumber", :name => "member[portablenumber]"
      assert_select "input#member_email", :name => "member[email]"
      assert_select "input#member_privilege", :name => "member[privilege]"
      assert_select "input#member_streetaddress", :name => "member[streetaddress]"
      assert_select "input#member_city", :name => "member[city]"
      assert_select "input#member_zip", :name => "member[zip]"
      assert_select "input#member_area", :name => "member[area]"
      assert_select "input#member_homephone", :name => "member[homephone]"
      assert_select "input#member_workphone", :name => "member[workphone]"
      assert_select "input#member_cellorotherphone", :name => "member[cellorotherphone]"
      assert_select "input#member_shirtsize", :name => "member[shirtsize]"
      assert_select "input#member_status", :name => "member[status]"
      assert_select "input#member_miscnotes", :name => "member[miscnotes]"
      assert_select "input#member_password", :name => "member[password]"
      assert_select "input#member_salt", :name => "member[salt]"
    end
  end
end
