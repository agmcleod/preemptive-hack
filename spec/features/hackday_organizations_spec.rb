require 'rails_helper'

feature 'Feature: Create hackday org' do
  background do
    login_for_feature
  end

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

feature 'Feature: edit hackday org' do
  background do
    login_for_feature
  end

  scenario 'owner edits with valid info' do
    hdo = FactoryGirl.create :hackday_organization
    visit hackday_organization_path(hdo)
    click_link 'Edit'
    name = "A different hack org name"
    fill_in 'Name', with: name
    click_button 'Save'
    expect(page).to have_content(name)
  end

  scenario 'not an owner, should not see link' do
    hdo = FactoryGirl.create :hackday_organization
    hdo.owners.destroy_all
    visit hackday_organization_path(hdo)
    within('.hackday_organization') do
      expect(page).to_not have_content('Edit')
    end
  end

  scenario 'not an owner, should get redirected' do
    hdo = FactoryGirl.create :hackday_organization
    hdo.owners.destroy_all
    visit edit_hackday_organization_path(hdo)
    expect(current_path).to eq(hackday_organization_path(hdo))
  end
end

feature 'Feature: add member to the organization' do
  background do
    login_for_feature
  end

  scenario 'owner' do
    hdo = FactoryGirl.create :hackday_organization
    u = FactoryGirl.create :user
    visit hackday_organization_path(hdo)
    select u.username, from: 'user_id'
    click_button 'Add Member'
    expect(HackdayOrganization.last.users.count).to eq(1)
  end

  scenario 'not an owner' do
    hdo = FactoryGirl.create :hackday_organization
    hdo.hackday_organizations_owners.destroy_all
    visit hackday_organization_path(hdo)
    expect(page).to_not have_content('Add Member')
  end
end

feature 'Feature: remove member from organization' do
  scenario 'owner' do
    login_for_feature
    hdo = FactoryGirl.create :hackday_organization
    u = FactoryGirl.create :user
    hdo.users << u
    hdo.save
    visit hackday_organization_path(hdo)
    click_link "remove_member_#{u.id}"
    expect(page).to_not have_css("#member_#{u.id}")
  end
end
