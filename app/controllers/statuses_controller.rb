class StatusesController < ApplicationController
  
  def index
    @statuses = Status.all
  end

  def show
    @status = Status.find(params[:id])
  end

  def new
    @status = Status.new
  end
  
  def create
    @status = Status.new(params[:status])

    respond_to do |format|
      if @status.save
        format.html { redirect_to(@status, :notice => 'New Status Successfully Created') }
        format.xml  { render :xml => @status, :status => :created, :location => @status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @status = Status.find(params[:id])
  end
  
  def update
     @status = Status.find(params[:id])
     if @status.update_attributes(params[:status])
       redirect_to statuses_path, :notice => 'Status was successfully updated.'
     else
       redirect_to status_path(@status), :notice => 'Status could not be updated'
     end
     
  end

  def list_for_status
    @status = Status.find(params[:id])
    @deliveries = []
    @deliveries_for_status = @status.deliveries(:order => "planned_date")
    @deliveries_for_status.each do |delivery|
      @deliveries << delivery
    end
    @deliveries   
    respond_to do |format|
      format.html
      format.xml  # { render :xml => @deliverables }
    end
  end


end
