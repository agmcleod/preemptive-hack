require 'spec_helper'

feature 'Feature: Sign In' do
  scenario 'existing user' do
    user = FactoryGirl.create :user, password: 'abc123', password_confirmation: 'abc123'
    visit root_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'abc123'
    click_button 'Login'
    expect(page).to have_content('Logged In')
  end

  scenario 'incorrect information' do
    visit root_path
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'abc123'
    click_button 'Login'
    expect(page).to have_content('Your email address or password was incorrect')
  end
end

feature 'Feature: Log Out' do
  scenario 'Log in than out' do
    user = FactoryGirl.create :user, password: 'abc123', password_confirmation: 'abc123'
    visit root_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'abc123'
    click_button 'Login'
    click_link 'Logout'
    expect(page).to have_content('Login')
  end
end