require 'factory_girl'

FactoryGirl.define do
  factory :hackday_organization do
    name Faker::Company.name
    before(:build) do
      owners << User.find_by_username 'guestaccount'
    end
  end
end
