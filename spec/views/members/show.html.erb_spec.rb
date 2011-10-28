require 'spec_helper'

describe "members/show.html.erb" do
  before(:each) do
    @member = assign(:member, stub_model(Member,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fullname/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Portablename/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Privilege/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Streetaddress/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Zip/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Area/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Homephone/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Workphone/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Cellorotherphone/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Shirtsize/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Status/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Miscnotes/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Password/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Salt/)
  end
end
