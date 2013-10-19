require 'spec_helper'

def visit_hackday_org
  h = FactoryGirl.create(:hackday_organization)
  visit hackday_organizations_path
  click_link h.name
end

feature 'add to hackday org' do
  scenario 'valid form data' do
    visit_hackday_org
    click_link "Create new Hackday"
    fill_in 'Start Date', with: '2013-10-19 00:00:00'
    fill_in 'End Date', with: '2013-10-22 00:00:00'
    click_button 'Save'
    expect(page).to have_content('Starts at: 2013-10-19 00:00:00')
  end
end
