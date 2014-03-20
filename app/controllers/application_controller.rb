class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  before_filter :require_login

  def current_user
    return if session[:user_id].blank?
    user = User.find_by_id session[:user_id]
    if user.nil?
      redirect_to logout_url
    else
      @current_user ||= user
    end
  end

  def login_as_guest
    session[:user_id] = User.guest_account.id unless session[:user_id]
  end

private
  def require_login
    redirect_to login_url if current_user.nil?
  end

end