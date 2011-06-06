class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  def index
    @messages = current_user.received_messages.order('updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = current_user.received_messages.find(params[:id])

    respond_to do |format|
      @message.update_attribute :new_message, false
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @user = current_user
    @message = @user.sent_messages.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = current_user.sent_messages.new(params[:message])

    respond_to do |format|
      if @message.save
        format.html { redirect_to(user_messages_path(current_user), :notice => 'Message was successfully Sent.') }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = current_user.received_messages.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(user_messages_path(current_user)) }
    end
  end

  def query
    @users = User.auto_fill(params[:term])

    logger.debug "This is the USERS" + @users.first.username
    render :json => @users.collect{|x| {:label => x.username, :id => x.id}}
  end
end
