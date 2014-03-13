require 'spec_helper'

def visit_hackday_org
  hackday_org = FactoryGirl.create :hackday_organization
  visit hackday_organizations_path
  click_link hackday_org.name
end

feature 'Add hardware to hackday' do
  scenario 'multiple selected' do
    hackday_org = FactoryGirl.create :hackday_organization
    hackday = FactoryGirl.create :hackday, hackday_organization: hackday_org
    names = %w(printer mouse keyboard nintendo2ds).collect { |n| FactoryGirl.create(:hardware, name: n); n }
    visit hackday_path(hackday)
    click_link 'Edit Available Hardware'
    names[0..2].each { |n| check n }
    click_button 'Save'
    expect(page).to have_css('.hardware li', count: 3)
  end

  scenario 'not an owner, hide link' do
    hdo = FactoryGirl.create :hackday_organization
    hdo.owners.destroy_all
    hackday = FactoryGirl.create :hackday, hackday_organization: hdo
    visit hackday_path(hackday)
    expect(page).to_not have_content('Edit Available Hardware')
  end

  scenario 'not an owner, get redirected' do
    hdo = FactoryGirl.create :hackday_organization
    hdo.owners.destroy_all
    hackday = FactoryGirl.create :hackday, hackday_organization: hdo
    visit edit_hackday_organization_hackday_path(hdo, hackday)
    expect(current_path).to eq(hackday_path(hackday))
  end
end

feature 'add a hackday' do
  scenario 'valid form data' do
    hackday_org = FactoryGirl.create :hackday_organization
    visit hackday_organizations_path
    click_link hackday_org.name
    click_link "Create New Hackday"
    fill_in 'Name', with: 'Ultima Hack'
    fill_in 'Start Date', with: '2013-10-19 00:00:00'
    fill_in 'End Date', with: '2013-10-22 00:00:00'
    click_button 'Save'
    expect(page).to have_content('Ultima Hack')
  end

  scenario 'not an owner' do
    hdo = FactoryGirl.create :hackday_organization
    hdo.owners.destroy_all
    visit hackday_organization_path(hdo)
    expect(page).to_not have_content('Create New Hackday')
  end

  scenario 'not an owner, new path' do
    hdo = FactoryGirl.create :hackday_organization
    hdo.owners.destroy_all
    visit new_hackday_organization_hackday_path(hdo)
    expect(current_path).to eq(hackday_organization_path(hdo))
  end
end
