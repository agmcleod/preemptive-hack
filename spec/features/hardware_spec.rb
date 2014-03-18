require 'spec_helper'

feature 'Feature: listing hackday org hardware' do
  background do
    login_for_feature
  end
  scenario 'hardware created' do
    hdo = FactoryGirl.create :hackday_organization
    3.times.each { FactoryGirl.create(:hardware, hackday_organization: hdo) }
    visit hackday_organization_path(hdo)
    expect(page).to have_css('.hardware li', count: 3)
  end
end

feature 'Feature: Add hardware to organization' do
  background do
    login_for_feature
  end
  scenario 'valid information' do
    hdo = FactoryGirl.create :hackday_organization
    visit hackday_organization_path(hdo)
    click_link 'Add Hardware Item'
    fill_in 'Name', with: 'Raspberry Pi'
    click_button 'Add'
  end

  scenario 'not an owner, should get redirected' do
    hdo = FactoryGirl.create :hackday_organization
    hdo.hackday_organizations_owners.destroy_all
    visit new_hackday_organization_hardware_path(hdo)
    expect(current_path).to eq(hackday_organization_path(hdo))
  end

  scenario 'not an owner or member, should not see link' do
    hdo = FactoryGirl.create :hackday_organization
    hdo.hackday_organizations_owners.destroy_all
    visit hackday_organization_path(hdo)
    expect(page).to_not have_content('Add Hardware Item')
  end

  scenario 'is a member, should see link' do
    hdo = FactoryGirl.create :hackday_organization
    hdo.hackday_organizations_owners.destroy_all
    hdo.users << User.last
    hdo.save
    visit hackday_organization_path(hdo)
    expect(page).to have_content('Add Hardware Item')
  end
end
