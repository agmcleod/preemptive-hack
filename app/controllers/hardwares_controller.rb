class HardwaresController < ApplicationController
  before_filter :load_hackday_organization

  def create
    check_ownership
    @hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
    @hackday_organization.hardwares.build(hardware_params)
    if @hackday_organization.save
      redirect_to @hackday_organization, notice: "Hardware item successfully added."
    else
      render :new
    end
  end

  def new
    check_ownership
    @hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
    @hardware = Hardware.new
  end

private

  def check_ownership
    redirect_to hackday_organization_url(@hackday_organization) unless @hackday_organization.is_owner? current_user
  end

  def hardware_params
    params.require(:hardware).permit(:name)
  end

  def load_hackday_organization
    @hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
  end
end
