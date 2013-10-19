require 'factory_girl'

FactoryGirl.define do
  factory :hardware do
    name { Faker::Name.name }
  end
end
