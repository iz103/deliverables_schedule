require 'spec_helper'

describe DeliverablesController do

  def mock_deliverables(stubs={})
    @mock_deliverables ||= mock_model(Deliverables, stubs)
  end

  describe "GET index" do
    it "assigns all deliverables as @deliverables" do
      Deliverables.stub!(:find).with(:all).and_return([mock_deliverables])
      get :index
      assigns[:deliverables].should == [mock_deliverables]
    end
  end

  describe "GET show" do
    it "assigns the requested deliverables as @deliverables" do
      Deliverables.stub!(:find).with("37").and_return(mock_deliverables)
      get :show, :id => "37"
      assigns[:deliverables].should equal(mock_deliverables)
    end
  end

  describe "GET new" do
    it "assigns a new deliverables as @deliverables" do
      Deliverables.stub!(:new).and_return(mock_deliverables)
      get :new
      assigns[:deliverables].should equal(mock_deliverables)
    end
  end

  describe "GET edit" do
    it "assigns the requested deliverables as @deliverables" do
      Deliverables.stub!(:find).with("37").and_return(mock_deliverables)
      get :edit, :id => "37"
      assigns[:deliverables].should equal(mock_deliverables)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created deliverables as @deliverables" do
        Deliverables.stub!(:new).with({'these' => 'params'}).and_return(mock_deliverables(:save => true))
        post :create, :deliverables => {:these => 'params'}
        assigns[:deliverables].should equal(mock_deliverables)
      end

      it "redirects to the created deliverables" do
        Deliverables.stub!(:new).and_return(mock_deliverables(:save => true))
        post :create, :deliverables => {}
        response.should redirect_to(deliverable_url(mock_deliverables))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved deliverables as @deliverables" do
        Deliverables.stub!(:new).with({'these' => 'params'}).and_return(mock_deliverables(:save => false))
        post :create, :deliverables => {:these => 'params'}
        assigns[:deliverables].should equal(mock_deliverables)
      end

      it "re-renders the 'new' template" do
        Deliverables.stub!(:new).and_return(mock_deliverables(:save => false))
        post :create, :deliverables => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested deliverables" do
        Deliverables.should_receive(:find).with("37").and_return(mock_deliverables)
        mock_deliverables.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :deliverables => {:these => 'params'}
      end

      it "assigns the requested deliverables as @deliverables" do
        Deliverables.stub!(:find).and_return(mock_deliverables(:update_attributes => true))
        put :update, :id => "1"
        assigns[:deliverables].should equal(mock_deliverables)
      end

      it "redirects to the deliverables" do
        Deliverables.stub!(:find).and_return(mock_deliverables(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(deliverable_url(mock_deliverables))
      end
    end

    describe "with invalid params" do
      it "updates the requested deliverables" do
        Deliverables.should_receive(:find).with("37").and_return(mock_deliverables)
        mock_deliverables.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :deliverables => {:these => 'params'}
      end

      it "assigns the deliverables as @deliverables" do
        Deliverables.stub!(:find).and_return(mock_deliverables(:update_attributes => false))
        put :update, :id => "1"
        assigns[:deliverables].should equal(mock_deliverables)
      end

      it "re-renders the 'edit' template" do
        Deliverables.stub!(:find).and_return(mock_deliverables(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested deliverables" do
      Deliverables.should_receive(:find).with("37").and_return(mock_deliverables)
      mock_deliverables.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the deliverables list" do
      Deliverables.stub!(:find).and_return(mock_deliverables(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(deliverables_url)
    end
  end

end
