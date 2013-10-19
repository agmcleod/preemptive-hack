module HackdayOrganizationsHelper
  def hackday_as_date(hackday)
    hackday && hackday.start_date_formatted
  end
end
