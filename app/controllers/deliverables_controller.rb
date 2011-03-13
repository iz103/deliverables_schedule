class DeliverablesController < ApplicationController
  before_filter :require_user
  # GET /deliverables
  # GET /deliverables.xml
  def index
    # flash[:notice] = "logged in"  # TODO remove this after fixing cucumber 
    # @deliverables = Deliverable.all
    # @deliverables = Deliverable.paginate :page => params[:page]  # , :order => 'number'
    @deliverables = Deliverable.search(params[:search], params[:page])
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
    respond_to do |format|
      format.html
      format.xml  # { render :xml => @deliverables }
    end
  end
  
  # require 'FasterCSV'
  # require 'pp'
  # csv = FasterCSV.read("deliverables.csv", :headers => true)
  # pp csv
  # csv.each do |row|
    # Deliverable.create(:number => row['number'], :title => row['title'], :discipline_list => row ['tag1'], 
    #                   :document_type_list => row['tag2'], :tag_list => "#{row['tag3']}, #{row['tag4']}")
    #                 end
  
  
  
end
