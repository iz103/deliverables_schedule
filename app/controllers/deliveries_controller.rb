class DeliveriesController < ApplicationController
  before_filter :require_user
  
  def index
    @deliverable = Deliverable.find(params[:deliverable_id])
    @status = Status.find(params[:status_id])
    @deliverable_deliveries = @deliverable.deliveries
    @status_deliveries = @status.deliveries
    @delivery = Delivery.find(params[:id])
    @delivery_status = @delivery.status
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deliverables }
    end
  end
  
  
  def create
    @delivery = Delivery.new(params[:delivery])
    
    respond_to do |format|
      if @delivery.save
        flash[:notice] = 'Delivery was successfully created.'
        format.html { redirect_to(@delivery) }
        format.xml { render :xml => @delivery, :status => :created, :location => @delivery }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @delivery.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
