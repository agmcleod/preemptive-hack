class HackdayOrganizations::UsersController < ApplicationController
  def create
    hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
    check_ownership(hackday_organization)
    if hackday_organization.users_hackday_organizations.create(user_id: params[:user_id])
      redirect_to hackday_organization, notice: 'User has been added to the organization'
    else
      redirect_to hackday_organization, error: "User could not be added"
    end
  end

  def destroy
    hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
    check_ownership(hackday_organization)
    hackday_organization_user = UsersHackdayOrganization.where(:user_id => params[:id], :hackday_organization_id => hackday_organization.id).first
    hackday_organization_user.destroy
    redirect_to hackday_organization, notice: 'Member removed'
  end

private

  def check_ownership(hackday_organization)
    redirect_to hackday_organization unless hackday_organization.is_owner? current_user
  end
end
