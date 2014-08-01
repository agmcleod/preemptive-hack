require 'rails_helper'

feature 'Feature: New User' do
  scenario 'valid info, should be able to login' do
    visit root_path
    click_link 'Register here'
    fill_in 'user_username', with: 'testuser'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'alphabeta'
    fill_in 'user_password_confirmation', with: 'alphabeta'
    click_button 'Save'
    visit login_path
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'alphabeta'
    click_button 'Login'
    expect(page).to have_content('Logged In')
  end
end