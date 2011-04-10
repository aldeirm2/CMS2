class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to critical_processes_path, :alert => exception.message
  end
  filter_parameter_logging :password

  helper_method :current_user

  private

  # this method just returns the current user session by calling UserSession.find
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  #this method  returns the current user (i.e the user model that is currently logged in)
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  #method to check if there is a current user present, if not the visitor will be redirected to the login page.
  def require_user
      unless current_user
       # store_location
        flash[:error] = "You must be logged in to access this page"
        redirect_to login_path
        return false
      end
  end
end
