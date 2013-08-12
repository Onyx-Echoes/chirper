class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :user_logged_in?, :current_user

  def authenticate_user
    if not user_logged_in?
      redirect_to login_path
    end
  end

  protected

  def current_user
    @user ||= User.find(session[:user_id]) if user_logged_in?
  end

  def user_logged_in?
    not session[:user_id].blank?
  end

end