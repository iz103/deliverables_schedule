class DeliverablesController < ApplicationController
  before_filter :require_user
  def index
    # flash[:notice] = "logged in"  # TODO remove this after fixing cucumber 
    @search = Deliverable.search(params[:search])
    @deliverables = @search.paginate(:page => params[:page], :per_page => 100)
    
    # if "#{delivery.status_id}" == params[:search][:deliveries_status_id_equals] || params[:search][:deliveries_status_id_equals] == "" || params[:search] == nil || params[:search][:deliveries_with_progress] == prog_array[delivery.progresses_mask]  
    
    # {"search"=>{"deliveries_status_id_equals"=>"", "tagged_with_disciplines"=>"", "deliveries_with_progress"=>"complete"}, "commit"=>"Search"}
    
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render :xml => @deliverables }
    # end
  end
  
  def deliveries_index
    @search = Deliverable.search(params[:search])
    @deliverables = @search.paginate(:page => params[:page], :per_page => 100)
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render :xml => @deliverables }
    # end
  end

  def show
    @deliverable = Deliverable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deliverable }
      # format.js
    end
  end


  def new
    @deliverable = Deliverable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deliverable }
    end
  end


  def edit
    @deliverable = Deliverable.find(params[:id])
  end


  def create
    @deliverable = Deliverable.new(params[:deliverable])
    respond_to do |format|
      if @deliverable.save
        format.html { redirect_to(@deliverable, :notice => 'Deliverable was successfully created.') }
        format.xml  { render :xml => @deliverable, :status => :created, :location => @deliverable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deliverable.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @deliverable = Deliverable.find(params[:id])

    respond_to do |format|
      if @deliverable.update_attributes(params[:deliverable])
        format.html { redirect_to(@deliverable, :notice => 'Deliverable was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deliverable.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @deliverable = Deliverable.find(params[:id])
    @deliverable.destroy

    respond_to do |format|
      format.html { redirect_to(deliverables_url) }
      format.xml  { head :ok }
    end
  end
  
  def tag_cloud
    @tags = Deliverable.tag_counts_on(:tags)
  end
  
  def list_for_tag
    @tags = Tag.all
    @tag = Tag.find(params[:id])
    @deliverables = Deliverable.tagged_with(@tag)
    
    @deliveries = []
    # @deliverables = Deliverable.tagged_with(@tag)
    @deliverables.each do |deliverable|
      @deliveries_for_deliverable = deliverable.deliveries(:order => "planned_date")
      @deliveries_for_deliverable.each do |delivery|
        @deliveries << delivery
      end
    end
    @deliveries
                  
    respond_to do |format|
      format.html
      format.xml
    end
  end
  
  def manage
    if params[:commit] == "Delete"
      Deliverable.destroy_all(:id => params[:deliverables_ids])
    elsif params[:commit] == "Complete"
      unless params[:actual_date_select].blank?
        unless params[:actual_date_select].to_datetime > Date.today
          Delivery.update_all(["actual_date=?", params[:actual_date_select]], :id => params[:deliveries_ids])
        else 
          flash[:error] = "Cannot have an Actual Delivery date in the future"
        end
      else
        Delivery.update_all(["actual_date=?", DateTime.now], :id => params[:deliveries_ids])
      end
    elsif params[:commit] == "Incomplete"
      Delivery.update_all(["actual_date=?", nil], :id => params[:deliveries_ids])
    elsif params[:commit] == "Edit"
       (session[:deliveries_ids] = params[:deliveries_ids]
       redirect_to edit_multiple_deliveries_path) and return
    end
      redirect_to deliveries_index_deliverables_path
  end
      
end


