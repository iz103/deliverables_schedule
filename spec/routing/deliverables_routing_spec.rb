require 'spec_helper'

describe DeliverablesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/deliverables" }.should route_to(:controller => "deliverables", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/deliverables/new" }.should route_to(:controller => "deliverables", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/deliverables/1" }.should route_to(:controller => "deliverables", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/deliverables/1/edit" }.should route_to(:controller => "deliverables", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/deliverables" }.should route_to(:controller => "deliverables", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/deliverables/1" }.should route_to(:controller => "deliverables", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/deliverables/1" }.should route_to(:controller => "deliverables", :action => "destroy", :id => "1") 
    end
  end
end
