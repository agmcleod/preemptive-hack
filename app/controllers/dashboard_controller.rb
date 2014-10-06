class DashboardController < ApplicationController
  def index
    @hackday_organization = HackdayOrganization.first
  end
end
