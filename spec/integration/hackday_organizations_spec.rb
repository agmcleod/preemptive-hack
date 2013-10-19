require 'spec_helper'

feature 'Create hackday org' do
  def goto_new_page
    visit root_path
    click_link 'Hackday Organizations'
    click_link 'New Hackday Organization'
  end
  scenario 'valid name' do
    goto_new_page
    fill_in 'name', with: "Ruby Hacknight"
    expect(page).to have_content('Ruby Hacknight')
  end
end
