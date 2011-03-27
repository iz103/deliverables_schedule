class DeliveriesController < ApplicationController
  before_filter :require_user
  
  def index
    unless params[:deliverable_id]
      @chart_deliveries = Delivery.all(:order => "planned_date")
      @deliveries = Delivery.search(params[:search], params[:page])
      # @deliveries = Delivery.search(params[:discipline_list], params[:tag_list], params[:page])
      @text = "All deliverables"
    else
    # @cumulative = Delivery.planned_date_count
    @deliverable = Deliverable.find(params[:deliverable_id])
    @deliveries = @deliverable.deliveries
    @text = @deliverable.number
    # @delivery = @deliverable.delivery
    end
    # respond_to do |format|
    #   # format.html # index.html.erb
    #   # format.xml  { render :xml => @deliverables }
    # end
  end
  
  def show
    @deliverable = Deliverable.find(params[:deliverable_id])
    @delivery = @deliverable.delivery

    respond_to do |format|
      format.html # show.html.erb
      # format.xml  { render :xml => @deliverable }
    end
  end
  
  def new
    @deliverable = Deliverable.find(params[:deliverable_id])
    @statuses = Status.all
    # @delivery = @deliverable.deliveries.build
    @delivery = Delivery.new
    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.xml  { render :xml => @deliverable }
    # end
  end
  
  def edit
    @deliverable = Deliverable.find(params[:deliverable_id])
    @delivery = Delivery.find(params[:id])
    @statuses = Status.all
  end
  

  def create
    @deliverable = Deliverable.find(params[:deliverable_id])
    @delivery = @deliverable.deliveries.build(params[:delivery]) #was :delivery_id before
    @delivery.save
    # @delivery = Delivery.new(params[:delivery])
    # @status = @deliverable.status.build
    # @status.deliveries.build(params[:delivery])
    # @status.save
    # # @delivery.status.build(:deliverable_id => params[:deliverable_id])
    # # @delivery.save
    redirect_to deliverable_deliveries_path(@deliverable)
  end
  
  
  def update
     @deliverable = Deliverable.find(params[:deliverable_id])
     @delivery = @deliverable.deliveries.find(params[:id])
     @delivery.update_attributes(params[:delivery])
     redirect_to deliverable_deliveries_path(@deliverable)
  end
     # respond_to do |format|
     #        if @deliverable.update_attributes(params[:deliverable])
     #          format.html { redirect_to(@deliverable, :notice => 'Deliverable was successfully updated.') }
     #          format.xml  { head :ok }
     #        else
     #          format.html { render :action => "edit" }
     #          format.xml  { render :xml => @deliverable.errors, :status => :unprocessable_entity }
     #        end
     #   end
  
  
  # 

  # def create
  #    @deliverable = Deliverable.find(params[:deliverable_id])
  #    @delivery = @deliverable.deliveries.build(params[:delivery])
  #    respond_to do |format|
  #      if @delivery.save
  #        flash[:notice] = 'Delivery was successfully created.'
  #        format.html { redirect_to deliverable_url(@delivery.deliverable_id) }
  #        # format.xml { render :xml => @delivery, :status => :created, :location => @delivery }
  #      else
  #        format.html { render :action => "new" }
  #        format.xml { render :xml => @delivery.errors, :status => :unprocessable_entity }
  #      end
  #    end
    # end

  
def complete
  # params[:deliveries_ids].each do |delivery_id|
  #   if Delivery.find(delivery_id).actual_date?
  #     Delivery.find(delivery_id).actual_date = nil
  #   else
  #     Delivery.find(delivery_id).actual_date = DateTime.now
  #   end
  # end
      
      
  if params[:commit] == "Complete"
    Delivery.update_all(["actual_date=?", DateTime.now], :id => params[:deliveries_ids])
  elsif params[:commit] == "Incomplete"
    Delivery.update_all(["actual_date=?", nil], :id => params[:deliveries_ids])
  elsif params[:commit] == "Delete"
    Delivery.destroy_all(:id => params[:deliveries_ids])
  end
  
  if params[:deliverable_id]
    redirect_to deliverable_deliveries_path
  else 
    redirect_to deliveries_path
  end
  
end


    
    
    

  
end
