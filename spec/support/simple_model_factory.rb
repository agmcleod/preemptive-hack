def default_hackday_org
  org = HackdayOrganization.new(name: "Some Company")
  org.owners << User.first_or_create(username: 'testuser', password: 'abc123', password_confirmation: 'abc123', email: 'test@example.com')
  org.users.build username: Faker::Internet.user_name, email: Faker::Internet.email
  org
end

def login_for_feature
  user = FactoryGirl.create :user
  visit login_path
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password
  click_button 'Login'
end