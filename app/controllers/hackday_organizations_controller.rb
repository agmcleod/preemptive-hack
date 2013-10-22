class HackdayOrganizationsController < ApplicationController
  before_action :set_hackday_organization, only: [:show, :edit, :update, :destroy]

  def create
    @hackday_organization = current_user.owned_hackday_organizations.build(hackday_organization_params)
    @hackday_organization.owners << current_user
    if @hackday_organization.save
      redirect_to @hackday_organization, notice: 'Hackday organization was successfully created.'
    else
      render 'new'
    end
  end

  def edit

  end

  def index
    @hackday_organizations = HackdayOrganization.all
  end

  def new
    @hackday_organization = HackdayOrganization.new
  end

  def show

  end

  def update
    if @hackday_organization.update(hackday_organization_params)
      redirect_to @hackday_organization, notice: 'Hackday organization was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @hackday_organization.destroy
    redirect_to hackday_organizations_url
    head :no_content
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_hackday_organization
    @hackday_organization = HackdayOrganization.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hackday_organization_params
    params.require(:hackday_organization).permit(:name)
  end
end
