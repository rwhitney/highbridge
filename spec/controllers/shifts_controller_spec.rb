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

describe ShiftsController do
  login_admin
  
  before(:each) do
    @russ = FactoryGirl.create(:russ)
    @lisa = FactoryGirl.create(:lisa)
    @paul = FactoryGirl.create(:paul)
    @drew = FactoryGirl.create(:drew)
    @dennis = FactoryGirl.create(:dennis)
  end
  
  # This should return the minimal set of attributes required to create a valid
  # Shift. As you add validations to Shift, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      :e1member_id => @paul.id,
      :e2member_id => @lisa.id,
      :dmember_id => @russ.id,
      :shiftdate => Date.today,
      :shiftnum => 1,
    }
  end

  describe "GET index" do
    it "assigns all shifts as @shifts" do
      shift = Shift.create! valid_attributes
      get :index
      assigns(:shifts).should eq([shift])
    end
  end

  describe "GET show" do
    it "assigns the requested shift as @shift" do
      shift = Shift.create! valid_attributes
      get :show, :id => shift.id
      assigns(:shift).should eq(shift)
    end
  end

  describe "GET new" do
    it "assigns a new shift as @shift" do
      get :new
      assigns(:shift).should be_a_new(Shift)
    end
  end

  describe "GET edit" do
    it "assigns the requested shift as @shift" do
      shift = Shift.create! valid_attributes
      get :edit, :id => shift.id
      assigns(:shift).should eq(shift)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Shift" do
        expect {
          post :create, :shift => valid_attributes
        }.to change(Shift, :count).by(1)
      end

      it "assigns a newly created shift as @shift" do
        post :create, :shift => valid_attributes
        assigns(:shift).should be_a(Shift)
        assigns(:shift).should be_persisted
      end

      it "redirects to the created shift" do
        post :create, :shift => valid_attributes
        response.should redirect_to(Shift.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved shift as @shift" do
        # Trigger the behavior that occurs when invalid params are submitted
        Shift.any_instance.stub(:save).and_return(false)
        post :create, :shift => {}
        assigns(:shift).should be_a_new(Shift)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Shift.any_instance.stub(:save).and_return(false)
        post :create, :shift => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested shift" do
        shift = Shift.create! valid_attributes
        # Assuming there are no other shifts in the database, this
        # specifies that the Shift created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Shift.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => shift.id, :shift => {'these' => 'params'}
      end

      it "assigns the requested shift as @shift" do
        shift = Shift.create! valid_attributes
        put :update, :id => shift.id, :shift => valid_attributes
        assigns(:shift).should eq(shift)
      end

      it "redirects to the shift" do
        shift = Shift.create! valid_attributes
        put :update, :id => shift.id, :shift => valid_attributes
        response.should redirect_to(shift)
      end
    end

    describe "with invalid params" do
      it "assigns the shift as @shift" do
        shift = Shift.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Shift.any_instance.stub(:save).and_return(false)
        put :update, :id => shift.id, :shift => {}
        assigns(:shift).should eq(shift)
      end

      it "re-renders the 'edit' template" do
        shift = Shift.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Shift.any_instance.stub(:save).and_return(false)
        put :update, :id => shift.id, :shift => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested shift" do
      shift = Shift.create! valid_attributes
      expect {
        delete :destroy, :id => shift.id
      }.to change(Shift, :count).by(-1)
    end

    it "redirects to the shifts list" do
      shift = Shift.create! valid_attributes
      delete :destroy, :id => shift.id
      response.should redirect_to(shifts_url)
    end
  end

end
