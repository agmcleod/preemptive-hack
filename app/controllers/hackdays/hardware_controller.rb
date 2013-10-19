class Hackdays::HardwareController < ApplicationController
  before_filter :load_hackday

  def create
    params[:hardware_ids].each do |id, checked|
      @hackday.hardwares_hackdays.build(hardware_id: id) unless @hackday.has_hardware_id?(id)
    end
    if @hackday.save
      redirect_to @hackday, notice: "Hardware items added to hackday"
    else
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
