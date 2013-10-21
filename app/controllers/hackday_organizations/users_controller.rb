class HackdayOrganizations::UsersController < ApplicationController
  def create
    hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
    if hackday_organization.create_test_user
      redirect_to hackday_organization, notice: 'Test user added'
    else
      redirect_to hackday_organization, error: "Test user count not be created"
    end
  end
end
