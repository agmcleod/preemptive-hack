class HardwaresController < ApplicationController
  before_filter :load_hackday_organization, except: [:index]

  def create
    check_ownership
    @hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
    if hardware = Hardware.find_by_name(hardware_params[:name])
      @hackday_organization.hardwares << hardware
    else
      @hardware = @hackday_organization.hardwares.build(hardware_params)
    end
    if @hackday_organization.save
      redirect_to @hackday_organization, notice: "Hardware item successfully added."
    else
      render :new
    end
  end

  def index
    render json: Hardware.all.to_json
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
