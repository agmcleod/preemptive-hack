require 'spec_helper'

def visit_hackday_org
  hackday_org = FactoryGirl.create :hackday_organization
  visit hackday_organizations_path
  click_link hackday_org.name
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

feature 'Add hardware to hackday' do
  scenario 'multiple selected' do
    hackday_org = FactoryGirl.create :hackday_organization
    hackday = FactoryGirl.create :hackday, hackday_organization: hackday_org
    names = %w(printer mouse keyboard).collect { |n| FactoryGirl.create(:hardware, name: n); n }
    visit hackday_path(hackday)
    click_link 'Add Hardware'
    names.each { |n| check n }
    click_button 'Add'
    expect(page).to have_css('.hardware li', count: 3)
  end
end
