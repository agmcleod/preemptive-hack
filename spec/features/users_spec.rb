require 'rails_helper'

feature 'Feature: edit user' do
  scenario 'change username' do
    login_for_feature
    click_link 'Edit My Info'
    fill_in 'user_username', with: "anewname"
    click_button 'Save'
    expect(User.last.username).to eq('anewname')
  end
end