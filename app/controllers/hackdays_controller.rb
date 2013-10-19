class HackdaysController < ApplicationController
  before_action :load_hackday_organization

  def create
    @hackday = @hackday_organization.hackdays.build(hackday_params)
    if @hackday.save
      redirect_to [@hackday_organization, @hackday], notice: "Hackday successfully created."
    else
      render :new
    end
  end

  def edit
    @hackday ||= Hackday.find params[:id]
  end

  def new
    @hackday = Hackday.new
  end

  def show
    @hackday ||= Hackday.find params[:id]
  end

  def update
    @hackday ||= Hackday.find params[:id]
    if @hackday.update_attributes(hackday_params)
      redirect_to [@hackday_organization, @hackday], notice: "Hackday information successfully updated"
    else
      render :edit
    end
  end

private

  def load_hackday_organization
    if params[:hackday_organization_id]
      @hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
    else
      @hackday = Hackday.find params[:id]
      @hackday_organization = @hackday.hackday_organization
    end
  end

  def hackday_params
    params.require(:hackday).permit(:start_date, :end_date)
  end
end
