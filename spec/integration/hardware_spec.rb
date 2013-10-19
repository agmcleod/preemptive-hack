require 'spec_helper'

feature 'listing hardware' do
  scenario 'hardware created' do
    hdo = FactoryGirl.create :hackday_organization
    3.times.each { FactoryGirl.create(:hardware, hackday_organization: hdo) }
    visit hackday_organization_path(hdo)
    expect(page).to have_css('.hardware li', count: 3)
  end
end

feature 'Add hardware to organization' do
  scenario 'valid information' do
    hdo = FactoryGirl.create :hackday_organization
    visit hackday_organization_path(hdo)
    click_link 'Add Hardware Item'
    fill_in 'Name', with: 'Raspberry Pi'
    click_button 'Add'
  end
end
