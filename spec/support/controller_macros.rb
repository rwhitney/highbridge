module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @current_user = FactoryGirl.create(:admin) # Using factory girl as an example
      sign_in @current_user
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:member]
      @current_user = FactoryGirl.create(:member)
      sign_in @current_user
    end
  end
end