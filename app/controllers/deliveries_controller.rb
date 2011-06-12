class DeliveriesController < ApplicationController
  before_filter :require_user
  
  def index
    unless params[:deliverable_id]
      @all_deliveries = Delivery.all(:order => "planned_date")
      @search = Delivery.search(params[:search]) #need to git rid of
      @deliveries = @search.paginate(:page => params[:page], :per_page => 100) #need to git rid of
      @text = "All deliverables"
    else
    
      @deliverable = Deliverable.find(params[:deliverable_id])
      @deliveries = @deliverable.deliveries
      @text = @deliverable.number
    
    end
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
    authorize! :new, @delivery
    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.xml  { render :xml => @deliverable }
    # end
  end
  
  def edit
    @deliverable = Deliverable.find(params[:deliverable_id])
    @delivery = Delivery.find(params[:id])
    @statuses = Status.all
    authorize! :edit, @delivery
  end
  

  def create
    @deliverable = Deliverable.find(params[:deliverable_id])
    @delivery = @deliverable.deliveries.build(params[:delivery]) #was :delivery_id before
    @delivery.save
    redirect_to deliverable_deliveries_path(@deliverable)
  end
  
  
  def update
     @deliverable = Deliverable.find(params[:deliverable_id])
     @delivery = @deliverable.deliveries.find(params[:id])
     @delivery.update_attributes(params[:delivery])
     redirect_to deliverable_deliveries_path(@deliverable)
  end
  
def complete
      
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

def edit_multiple
  # if params[:deliveries_ids]
  if session[:deliveries_ids]
    # @deliveries = Delivery.find(params[:deliveries_ids])
    @deliveries = Delivery.find(session[:deliveries_ids])
  else
    redirect_to deliverables_path
    flash[:error] = "No deliveries selected"
  end
end

def update_multiple
  # unless params[:delivery][:actual_date] and params[:delivery][:actual_date].to_datetime > Date.today
    @deliveries = Delivery.find(params[:deliveries_ids])
    @deliveries.each do |delivery|
      delivery.update_attributes!(params[:delivery].reject { |k,v| v.blank? })
    end
    flash[:notice] = "Updated deliveries"
  # else
  #     flash[:error] = "Cannot have an Actual Delivery date in the future"
  #   end
    redirect_to deliveries_index_deliverables_path
end


    
    
    

  
end
