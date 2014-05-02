class Hackdays::HardwareController < ApplicationController
  before_filter :load_hackday

  def create
    if @hackday.sync_hardware(params[:hardware_ids])
      redirect_to @hackday, notice: "Hardware items added to hackday"
    else
      @hardwares = @hackday.hackday_organization_hardwares
      render :new
    end
  end

  def new
    @hardwares = @hackday.hackday_organization_hardwares
  end

private

  def load_hackday
    @hackday = Hackday.includes(:hackday_organization).find params[:hackday_id]
  end
end
