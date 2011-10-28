require 'spec_helper'

describe "members/index.html.erb" do
  before(:each) do
    assign(:members, [
      stub_model(Member,
        :fullname => "Fullname",
        :portablename => "Portablename",
        :portablenumber => 1,
        :email => "Email",
        :privilege => "Privilege",
        :streetaddress => "Streetaddress",
        :city => "City",
        :zip => "Zip",
        :area => "Area",
        :homephone => "Homephone",
        :workphone => "Workphone",
        :cellorotherphone => "Cellorotherphone",
        :shirtsize => "Shirtsize",
        :status => "Status",
        :miscnotes => "Miscnotes",
        :password => "Password",
        :salt => "Salt"
      ),
      stub_model(Member,
        :fullname => "Fullname",
        :portablename => "Portablename",
        :portablenumber => 1,
        :email => "Email",
        :privilege => "Privilege",
        :streetaddress => "Streetaddress",
        :city => "City",
        :zip => "Zip",
        :area => "Area",
        :homephone => "Homephone",
        :workphone => "Workphone",
        :cellorotherphone => "Cellorotherphone",
        :shirtsize => "Shirtsize",
        :status => "Status",
        :miscnotes => "Miscnotes",
        :password => "Password",
        :salt => "Salt"
      )
    ])
  end

  it "renders a list of members" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Fullname".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Portablename".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Privilege".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Streetaddress".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Area".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Homephone".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Workphone".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Cellorotherphone".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Shirtsize".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Miscnotes".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Salt".to_s, :count => 2
  end
end
