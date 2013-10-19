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
    expect(page).to have_content('1 error prohibited')
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
