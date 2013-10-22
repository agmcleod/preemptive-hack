require 'spec_helper'

feature 'Create hackday org' do
  def goto_new_page
    visit root_path
    click_link 'Hackday Organizations'
    click_link 'New Hackday Organization'
  end
  scenario 'valid name' do
    goto_new_page
    fill_in 'hackday_organization[name]', with: "Ruby Hacknight"
    click_button 'Save'
    expect(page).to have_content('Ruby Hacknight')
  end

  scenario 'invalid name' do
    goto_new_page
    click_button 'Save'
    expect(page).to have_css('#error_explanation')
  end
end

feature 'edit hackday org' do
  scenario 'owner edits with valid info' do
    pending
  end

  scenario 'not an owner' do
    pending
  end
end

feature 'add test user' do
  scenario 'clicks button' do
    h = FactoryGirl.create(:hackday_organization)
    hd = FactoryGirl.create(:hackday, hackday_organization: h)
    visit hackday_organizations_path
    click_link h.name
    click_button 'Add Test User'
    expect(page).to have_content('Test user added')
  end
end

feature 'listing hackday org hardware' do
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

  scenario 'not an owner' do
    pending
  end
end
