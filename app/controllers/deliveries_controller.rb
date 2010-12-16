class DeliveriesController < ApplicationController
  before_filter :require_user
  
  def index
    # unless params[:deliverable_id]
    #   @deliveries = Delivery.all
    # else
    @deliverable = Deliverable.find(params[:deliverable_id])
    @deliveries = @deliverable.deliveries 
    # end
    # respond_to do |format|
    #   # format.html # index.html.erb
    #   # format.xml  { render :xml => @deliverables }
    # end
  end
  
  def show
    @delivery = Delivery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      # format.xml  { render :xml => @deliverable }
    end
  end
  
  def new
    @deliverable = Deliverable.find(params[:deliverable_id])
    @statuses = Status.all
    @delivery = @deliverable.deliveries.build
    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.xml  { render :xml => @deliverable }
    # end
  end
  
  def create
    @deliverable = Deliverable.find(params[:deliverable_id])
    @delivery = @deliverable.deliveries.build(params[:delivery])
    respond_to do |format|
      if @delivery.save
        flash[:notice] = 'Delivery was successfully created.'
        format.html { redirect_to deliverable_url(@delivery.deliverable_id) }
        # format.xml { render :xml => @delivery, :status => :created, :location => @delivery }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @delivery.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
