require 'rexml/document'

class SubmissionsController < ApplicationController
  # GET /submissions
  # GET /submissions.xml
  def index
    @submissions = Submission.find(:all, :conditions => {:user_id => session[:user_id]}, :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @submissions }
    end
  end

  # GET /submissions/1
  # GET /submissions/1.xml
  def show
    @submission = Submission.find(params[:id])
    
    #now lets get the nice xml to display!
    xml = Ruote::Parser.to_xml(@submission.process_definition)
    doc = REXML::Document.new xml
    @nice_xml = ''
    doc.write(@nice_xml,2)
    @task_outputs = ''
    @submission.tasks.each do|t|
      @task_outputs += "\n== #{t.rank} - #{t.name} =====================\n\n"
      @task_outputs += "#{t.exec_output}\n"
    end
    
    flash[:error] = "Your submission appears to have an error and is probably stuck. Please contact your system administrator." if (! @submission.last_error.blank? && @submission.active?)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @submission }
    end
  end

  # GET /submissions/new
  # GET /submissions/new.xml
  def new
    @submission = Submission.new
    @workflow = Workflow.find(params[:id])
    
    c = 0
    @workflow.protocols.each do |p|
      @submission.tasks.build(:protocol => p, :rank => c)
      c += 1
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @submission }
    end
  end

  # GET /submissions/1/edit
  def edit
    @submission = Submission.find(params[:id])
  end

  # POST /submissions
  # POST /submissions.xml
  def create
    @submission = Submission.new(params[:submission])

    respond_to do |format|
      if @submission.save
        @submission.submit_job
        flash[:notice] = 'Submission was successfully created.'
        format.html { redirect_to(@submission) }
        format.xml  { render :xml => @submission, :status => :created, :location => @submission }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @submission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /submissions/1
  # PUT /submissions/1.xml
  def update
    @submission = Submission.find(params[:id])

    respond_to do |format|
      if @submission.update_attributes(params[:submission])
        flash[:notice] = 'Submission was successfully updated.'
        format.html { redirect_to(@submission) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @submission.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_options
    
    @options = Item.get(:index_all, :project_id => params[:project_id])
    
    
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.xml
  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy

    respond_to do |format|
      format.html { redirect_to(submissions_url) }
      format.xml  { head :ok }
    end
  end
end
