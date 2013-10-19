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
