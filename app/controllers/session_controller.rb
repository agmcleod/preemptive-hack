class SessionController < ApplicationController
  skip_before_filter :require_login

  def create
    user = User.find_by_email params[:email]
    if user && params[:password].present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged In!"
    else
      flash.now[:error] = "Your email address or password was incorrect. Please try again."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
