require 'factory_girl'

FactoryGirl.define do
  factory :hackday_organization do
    name Faker::Company.name
  end
end
