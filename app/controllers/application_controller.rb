class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?
# The line above makes the 'user_signed_in?' method into a helper method which means it will be accessible in the view as well as controller files.
#CMD SHIFT F will allow for a project-wide search

  def current_user
    @current_user ||= User.find session[:user_id]
  end
  helper_method :current_user


end
