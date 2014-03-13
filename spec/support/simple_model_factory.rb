def default_hackday_org
  org = HackdayOrganization.new(name: "Some Company")
  org.owners << User.guest_account
  org.users.build username: Faker::Internet.user_name, email: Faker::Internet.email
  org
end