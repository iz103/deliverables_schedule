class DeliveriesController < ApplicationController
  before_filter :require_user
  
  def index
    unless params[:deliverable_id]
      @all_deliveries = Delivery.all(:order => "planned_date")
      @search = Delivery.search(params[:search]) #need to git rid of
      @deliveries = @search.all.paginate(:page => params[:page], :per_page => 100) #need to git rid of
      
      # if params[:search]
      #         if params["search"]["tagged_with_disciplines"].empty?
      #           params["search"].delete("tagged_with_disciplines")
      #           deliveries_search_terms = params["search"]
      #           @search = Delivery.search(deliveries_search_terms)
      #         else
      #           deliverables_search_terms = {:tagged_with_disciplines => "#{params["search"]["tagged_with_disciplines"]}"}
      #           params["search"].delete("tagged_with_disciplines")
      #           deliveries_search_terms = params["search"]
      #           deliveries_results = Delivery.search(deliveries_search_terms).all #search for all deliveries of a certain status (thousands)
      #           deliverables_results = Deliverable.search(deliverables_search_terms).all
      #           deliverables_results_deliveries = []
      #           deliverables_results.each {|deliverable| 
      #             deliverable.deliveries.each {|delivery| 
      #               deliverables_results_deliveries << delivery} }
      #           @search = deliveries_results & deliverables_results_deliveries
      #         end
      #         @deliveries = @search   # .paginate(:page => params[:page])
      #       else 
      #         @search = Delivery.search(params[:search])           
      #         @deliveries = @search.all.paginate(:page => params[:page])
      #         @text = "All deliverables"
      #       end
    @text = "All deliverables"
    else
    
    @deliverable = Deliverable.find(params[:deliverable_id])
    @deliveries = @deliverable.deliveries
    @text = @deliverable.number
    
    end
    # respond_to do |format|
    #   # format.html # index.html.erb
    #   # format.xml  { render :xml => @deliverables }
    # end
  end
  
  
      # @deliveries = Delivery.search(params[:search], params[:page])
      
      # unless params[:search].has_key?("tag_equals")
        # @search = Delivery.search(params[:search])
  
  
  # else 
    # @search = Deliverable.search(params[:search])
    
    
    # @seacrh = Deliverable.tagged_with(params[:search][:tag_equals]
    
    # deliverables = Deliverable.tagged_with(params[:search][:tag_equals])
    # deliverables.each do |deliverable|
    # unless deliverable.deliveries.empty?
    #   deliveries << deliverable.deliveries
    # end
    # end
    # @deliveries
  # end
  
  # @deliverable = Deliverable.find(delivery.deliverable_id)
  
  
  
    # deliveries = []
    
  # deliverables = Deliverable.tagged_with(params[:search][:tag_equals])
  # deliverables.each do |deliverable|
  # unless deliverable.deliveries.empty?
  #   deliveries << deliverable.deliveries
  # end
  # end
  # deliveries
  
  # example params
  # {"commit"=>"Search", "page"=>"36", "search"=>{"status_id_equals"=>"3", "order"=>""}}
  
  # @cumulative = Delivery.planned_date_count
  # @delivery = @deliverable.delivery
  
  
  
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
    redirect_to deliverables_path
end


    
    
    

  
end
