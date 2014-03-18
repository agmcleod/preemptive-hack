class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:create, :new]

  def create
    @user = User.new user_params
    if @user.save
      redirect_to login_url, notice: "You have successfully registered"
    else
      render :new
    end
  end

  def index
  end

  def new
    @user = User.new
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end

end
