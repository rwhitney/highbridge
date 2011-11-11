require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe MembersController do
  login_admin  # this creates and logins in :user from /spec/factories/members.rb

  def valid_attributes
    m = FactoryGirl.build(:lisa)
    {
      :full_name => m.full_name,
      :first_name => m.first_name,
      :last_name => m.last_name,
      :training_level => m.training_level,
      :portable_name => m.portable_name,
      :portable_number => m.portable_number,
      :email => m.email,
      :status => m.status,
      :password => m.password,
      :admin_hr => m.admin_hr,
      :admin_calendar => m.admin_calendar,
      :admin_root => m.admin_root,
    }
  end

  describe "GET index" do
    it "assigns all members as @members" do
      #member = Member.find :first
      member = @current_user
      get :index
      assigns(:members).should eq([member])
    end
  end

  describe "GET show" do
    it "assigns the requested member as @member" do
      member = FactoryGirl.create(:lisa)
      get :show, :id => member.id
      assigns(:member).should eq(member)
    end
  end

  describe "GET new" do
    it "assigns a new member as @member" do
      get :new
      assigns(:member).should be_a_new(Member)
    end
  end

  describe "GET edit" do
    it "assigns the requested member as @member" do
      member = @current_user
      get :edit, :id => member.id
      assigns(:member).should eq(member)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "doesn't get an error" do
        post :create, :member => valid_attributes
        
        response.should redirect_to Member.last
      end
      
      it "creates a new Member" do
        expect {
          post :create, :member => valid_attributes
        }.to change(Member, :count).by(1)
      end

      it "assigns a newly created member as @member" do
        post :create, :member => valid_attributes
        assigns(:member).should be_a(Member)
        assigns(:member).should be_persisted
      end

      it "redirects to the created member" do
        post :create, :member => valid_attributes
        response.should redirect_to(Member.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved member as @member" do
        # Trigger the behavior that occurs when invalid params are submitted
        Member.any_instance.stub(:save).and_return(false)
        post :create, :member => {}
        assigns(:member).should be_a_new(Member)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Member.any_instance.stub(:save).and_return(false)
        post :create, :member => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested member" do
        member = Member.create! valid_attributes
        # Assuming there are no other members in the database, this
        # specifies that the Member created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Member.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => member.id, :member => {'these' => 'params'}
      end

      it "assigns the requested member as @member" do
        member = Member.create! valid_attributes
        put :update, :id => member.id, :member => valid_attributes
        assigns(:member).should eq(member)
      end

      it "redirects to the member" do
        member = Member.create! valid_attributes
        put :update, :id => member.id, :member => valid_attributes
        response.should redirect_to(member)
      end
    end

    describe "with invalid params" do
      it "assigns the member as @member" do
        member = Member.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Member.any_instance.stub(:save).and_return(false)
        put :update, :id => member.id, :member => {}
        assigns(:member).should eq(member)
      end

      it "re-renders the 'edit' template" do
        member = Member.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Member.any_instance.stub(:save).and_return(false)
        put :update, :id => member.id, :member => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested member" do
      member = Member.create! valid_attributes
      expect {
        delete :destroy, :id => member.id
      }.to change(Member, :count).by(-1)
    end

    it "redirects to the members list" do
      member = Member.create! valid_attributes
      delete :destroy, :id => member.id
      response.should redirect_to(members_url)
    end
  end

end
