class Hackdays::HardwareController < ApplicationController
  before_filter :load_hackday

  def create
    if @hackday.sync_hardware(params[:hardware_ids])
      redirect_to @hackday, notice: "Hardware items added to hackday"
    else
      @hardwares = Hardware.for_hackday_organization(@hackday.hackday_organization_id)
      render :new
    end
  end

  def new
    @hardwares = Hardware.for_hackday_organization(@hackday.hackday_organization_id)
  end

private

  def load_hackday
    @hackday = Hackday.find params[:hackday_id]
  end
end
