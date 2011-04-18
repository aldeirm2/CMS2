class MacroProcessesController < ApplicationController

  before_filter :require_user

  # GET /macro_processes
  # GET /macro_processes.xml
  def index
    @macro_processes = MacroProcess.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @macro_processes }
    end
  end

  # GET /macro_processes/1
  # GET /macro_processes/1.xml
  def show
    @macro_process = MacroProcess.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @macro_process }
    end
  end

  # GET /macro_processes/new
  # GET /macro_processes/new.xml
  def new
    @macro_process = MacroProcess.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @macro_process }
    end
  end

  # GET /macro_processes/1/edit
  def edit
    @macro_process = MacroProcess.find(params[:id])
  end

  # POST /macro_processes
  # POST /macro_processes.xml
  def create
    @macro_process = MacroProcess.new(params[:macro_process])

    respond_to do |format|
      if @macro_process.save
        format.html { redirect_to(@macro_process, :notice => 'Macro process was successfully created.') }
        format.xml  { render :xml => @macro_process, :status => :created, :location => @macro_process }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @macro_process.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /macro_processes/1
  # PUT /macro_processes/1.xml
  def update
    @macro_process = MacroProcess.find(params[:id])

    respond_to do |format|
      if @macro_process.update_attributes(params[:macro_process])
        format.html { redirect_to(@macro_process, :notice => 'Macro process was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @macro_process.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /macro_processes/1
  # DELETE /macro_processes/1.xml
  def destroy
    @macro_process = MacroProcess.find(params[:id])
    @macro_process.destroy

    respond_to do |format|
      format.html { redirect_to(macro_processes_url) }
      format.xml  { head :ok }
    end
  end
end
