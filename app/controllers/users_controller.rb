class UsersController < ApplicationController
  def create
    if User.create_test_user(params[:hackday_organization_id])
      redirect_to hackday_organization_url(params[:hackday_organization_id]), notice: "Test user added"
    else
      redirect_to hackday_organization_url(params[:hackday_organization_id]), error: "Test user had an error"
    end
  end

  def index
  end

  def new
  end
end
