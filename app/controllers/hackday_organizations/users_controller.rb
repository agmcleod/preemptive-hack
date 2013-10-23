class HackdayOrganizations::UsersController < ApplicationController
  def create
    hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
    redirect_to hackday_organization unless hackday_organization.is_owner? current_user
    if hackday_organization.users_hackday_organizations.build(user_id: params[:user_id])
      redirect_to hackday_organization, notice: 'User has been added to the organization'
    else
      redirect_to hackday_organization, error: "Test user count not be created"
    end
  end
end
