class HardwaresController < ApplicationController
  def create
    @hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
    @hackday_organization.hardwares.build(hardware_params)
    if @hackday_organization.save
      redirect_to @hackday_organization, notice: "Hardware item successfully added."
    else
      render :new
    end
  end

  def new
    @hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
    @hardware = Hardware.new
  end

private

  def hardware_params
    params.require(:hardware).permit(:name)
  end
end
