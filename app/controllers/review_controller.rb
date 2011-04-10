class ReviewController < ApplicationController
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  def edit
    @review = Review.find(params[:id])
    @critical_process = @review.critical_process
    authorize! :edit, @critical_process
  end

  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to(@review.critical_process, :notice => "Critical Process successfully moved to stage #{@review.stage} .") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

end
