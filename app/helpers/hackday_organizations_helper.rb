module HackdayOrganizationsHelper
  def available_users_for(hackday_organization)
    @users ||= User.available_users(hackday_organization.id)
  end

  def hackday_as_date(hackday)
    hackday && hackday.start_date_formatted
  end
end
