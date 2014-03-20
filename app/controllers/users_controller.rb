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

  def edit
    @user = current_user
  end

  def new
    @user = User.new
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params([:email, :username]))
      render :edit, notice: "Your info has been updated"
    else
      render :edit
    end
  end

private
  def user_params(permit_params = [])
    if permit_params.empty?
      permit_params = [:email, :password, :password_confirmation, :username]
    end
    params.require(:user).permit(*permit_params)
  end

end
