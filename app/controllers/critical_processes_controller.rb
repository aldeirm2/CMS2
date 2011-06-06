class CriticalProcessesController < ApplicationController

  before_filter :require_user
  authorize_resource

  # GET /critical_processes
  # GET /critical_processes.xml
  def index
    @critical_processes = CriticalProcess.authorized_critical_processes(current_user)
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @critical_processes }
    end
  end

  # GET /critical_processes/1
  # GET /critical_processes/1.xml
  def show
    @critical_process = CriticalProcess.find(params[:id])
    @categories = @critical_process.categories
    @lessons = @critical_process.lessons
    @key_terms = @critical_process.key_terms

    authorize! :read, @critical_process

    @comments = @critical_process.review.comments.order('updated_at DESC')

    stage = @critical_process.review.stage

    if stage.to_i == 1
      @new_stage = '2'
    elsif stage.to_i == 2
      @new_stage = "3"
    elsif stage.to_i == 3
      @new_stage = "approved"
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @critical_process }
    end
  end

  # GET /critical_processes/new
  # GET /critical_processes/new.xml
  def new
    @critical_process = CriticalProcess.new
    2.times do
      category = @critical_process.categories.build
      2.times { category.capability_building_blocks.build }
    end
    authorize! :new, @critical_process
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @critical_process }
    end
  end

  # GET /critical_processes/1/edit
  def edit
    @critical_process = CriticalProcess.find(params[:id])
    authorize! :edit, @critical_process
  end

  # POST /critical_processes
  # POST /critical_processes.xml
  def create
    @critical_process = CriticalProcess.new(params[:critical_process])

    respond_to do |format|
      if @critical_process.save
        format.html { redirect_to(@critical_process, :notice => 'New Critical Process Successfully Created.') }
        format.xml { render :xml => @critical_process, :status => :created, :location => @critical_process }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @critical_process.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /critical_processes/1
  # PUT /critical_processes/1.xml
  def update
    #here we make sure that if all key term checkbox's' are unpicked then set the key_term_ids array to empty
    params[:critical_process][:key_term_ids] ||= []
    @critical_process = CriticalProcess.find(params[:id])
    if params[:critical_process]["cp_secondary_id"].blank?
      @critical_process.update_attributes(params[:critical_process])
       UserMailer.review_edit(@critical_process).deliver
      redirect_to(@critical_process, :notice => 'Critical process was successfully updated.')
    else
      revision = CriticalProcess.create(params[:critical_process])
      revision.update_attribute :cp_secondary_id, params[:critical_process]['cp_secondary_id']
       UserMailer.new_version(revision).deliver
      redirect_to(revision, :notice => 'Revision was successfully updated.')
    end

  rescue ActiveRecord::StaleObjectError
    @critical_process.reload
    render :action => 'conflict'

  end


  # DELETE /critical_processes/1
  # DELETE /critical_processes/1.xml
  def destroy
    @critical_process = CriticalProcess.find(params[:id])
    @critical_process.destroy

    respond_to do |format|
      format.html { redirect_to(macro_processes_url) }
      format.xml { head :ok }
    end
  end

  #method to add a key term to a CP, this will be accessible through ajax (JavaScript)
  def key_term_add
    @critical_process = CriticalProcess.find(params[:id])
    @key_term = KeyTerm.find(params[:key_term])

    unless @critical_process.has_key_term(@key_term)
      @critical_process.key_terms << @key_term
      flash[:notice] = 'Key Term added successfully'
    else
      flash[:error] = 'Key term was already assigned'
    end
  end

  #method for removing key terms from a CP
  def key_term_remove
    @critical_process = CriticalProcess.find(params[:id])
    key_terms_ids = params[:key_terms]

    unless key_terms_ids.blank?
      key_terms_ids.each do |key_term_id|
        key_term = KeyTerm.find(key_term_id)
        if @critical_process.has_key_term(key_term)
          logger.info "removing key term #{key_term.id} from critical proccess"
          @critical_process.key_terms.delete(key_term)
          flash[:notice] = "Key term has been removed"
        end
      end
    end
  end

  def all_versions
    if params[:id]
      @critical_processes = CriticalProcess.where(:cp_secondary_id => params[:id]).order('updated_at DESC')
    end
  end

  def review_cps
    @critical_processes = current_user.pending_review
  end

  def cp_members
    if params[:id]
      @critical_process = CriticalProcess.find(params[:id])
      @reviewers = @critical_process.reviewers
      @editors = @critical_process.editors
    end
  end
end
