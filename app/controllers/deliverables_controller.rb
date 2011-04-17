class DeliverablesController < ApplicationController
  before_filter :require_user
  # GET /deliverables
  # GET /deliverables.xml
  def index
    # flash[:notice] = "logged in"  # TODO remove this after fixing cucumber 
    # @deliverables = Deliverable.all
    # @deliverables = Deliverable.paginate :page => params[:page]  # , :order => 'number'
    
    @search = Deliverable.search(params[:search])
    @deliverables = @search.all.paginate(:page => params[:page], :per_page => 100)
    
    # deliveries_status = params[:search][:deliveries_status_id_like]
    # @deliveries = Delivery.search(:status_id_like => deliveries_status)
    
    
    # {"commit"=>"Search", "search"=>{"tagged_with_disciplines"=>"ECOL", "deliveries_status_id_like"=>"3", "order"=>""}}
    
    
    
    
    
    
    
    
    
    
    # @deliverables = Deliverable.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deliverables }
    end
  end

  # GET /deliverables/1
  # GET /deliverables/1.xml
  def show
    @deliverable = Deliverable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deliverable }
      # format.js
    end
  end

  # GET /deliverables/new
  # GET /deliverables/new.xml
  def new
    @deliverable = Deliverable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deliverable }
    end
  end

  # GET /deliverables/1/edit
  def edit
    @deliverable = Deliverable.find(params[:id])
  end

  # POST /deliverables
  # POST /deliverables.xml
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

  # PUT /deliverables/1
  # PUT /deliverables/1.xml
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

  # DELETE /deliverables/1
  # DELETE /deliverables/1.xml
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
      format.xml  # { render :xml => @deliverables }
    end
  end
  
  
  
    # Parameters: {"commit"=>"Complete", "deliveries_ids"=>["13744", "13745"], 
    #   "authenticity_token"=>"7pXWK0JcEtPXTm58X6NqOt8AS4/7q6Olxs33A/RaIk4=", "actual_date_select"=>"04/10/2011"}
  
  
  
  def manage
    if params[:commit] == "Delete"
      Deliverable.destroy_all(:id => params[:deliverables_ids])
    elsif params[:commit] == "Complete"
      if params[:actual_date_select] and params[:actual_date_select] != ""
        # catch (:done) do 
        unless params[:actual_date_select].to_datetime > Date.today
        #params[:deliveries_ids].each do |id|
         # Delivery.find(id).update_attributes(:actual_date => params[:actual_date_select])
        #end
          Delivery.update_all(["actual_date=?", params[:actual_date_select]], :id => params[:deliveries_ids])
        else 
          flash[:error] = "Cannot have an Actual Delivery date in the future"
        end
        # throw :done unless params[:actual_date_select] <= Date.today 
      else
        Delivery.update_all(["actual_date=?", DateTime.now], :id => params[:deliveries_ids])
      end
    elsif params[:commit] == "Incomplete"
      Delivery.update_all(["actual_date=?", nil], :id => params[:deliveries_ids])
    end

    redirect_to deliverables_path
    # elsif params[:commit] == "Show Deliveries"
    #      deliveries = []
    #      Deliverable.all.each do |deliverable|
    #        deliveries << deliverable.deliveries
    #      end
  end
  
  # def list_deliveries_for_tag
  # 
  # all_deliveries
  # end
  
  # this is for uploading and parsing csv file
  
  
  # require 'FasterCSV'
  # require 'pp'
  # csv = FasterCSV.read("deliverables230311.csv", :headers => true)
  # pp csv
  # csv.each {|row| Deliverable.create(:number => row['number'], :title => row['title'], :discipline_list => row ['tag1'], :document_type_list => row['tag2'], :tag_list => "#{row['tag3']}, #{row['tag4']}")}

  # csv.each {|row| Deliverable.create(:number => row['number'], :title => row['title'], :discipline_list => row ['tag1'], :document_type_list => row['tag2'], :tag_list => row['tag3'])}





  
  
  # require 'pp'
  # csv = FasterCSV.read("AB3_Act.csv", :headers => true)
  # pp csv
  # csv.each {|row| Delivery.create(:deliverable_id => row['ID'], :planned_date => row['AB3_Actual'], :status_id => "2")}
  
  
  
  
  
  # csv.each {|row| Delivery.update_all(["actual_date=?", row['AB3_Actual']], :id => row['ID'])}
  
end


