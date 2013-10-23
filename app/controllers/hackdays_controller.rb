class HackdaysController < ApplicationController
  before_action :load_hackday_organization, only: [:create, :new]
  before_action :load_hackday_organization_from_hackday, only: [:edit, :show, :update]

  def create
    check_ownership
    @hackday = @hackday_organization.hackdays.build(hackday_params)
    if @hackday.save
      redirect_to [@hackday_organization, @hackday], notice: "Hackday successfully created."
    else
      render :new
    end
  end

  def edit
    check_ownership
    @hackday ||= Hackday.find params[:id]
  end

  def new
    check_ownership
    @hackday = Hackday.new
  end

  def show
    @hackday ||= Hackday.find params[:id]
  end

  def update
    check_ownership
    @hackday ||= Hackday.find params[:id]
    if @hackday.update_attributes(hackday_params)
      redirect_to [@hackday_organization, @hackday], notice: "Hackday information successfully updated"
    else
      render :edit
    end
  end

private

  def check_ownership
    unless @hackday_organization.is_owner? current_user
      if @hackday && @hackday.persisted?
        redirect_to @hackday
      else
        redirect_to @hackday_organization
      end
    end
  end

  def load_hackday_organization
    @hackday_organization = HackdayOrganization.find params[:hackday_organization_id]
  end

  def load_hackday_organization_from_hackday
    @hackday = Hackday.find params[:id]
    @hackday_organization = @hackday.hackday_organization
  end

  def hackday_params
    params.require(:hackday).permit(:end_date, :name, :start_date)
  end
end
