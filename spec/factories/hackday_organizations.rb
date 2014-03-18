require 'factory_girl'

FactoryGirl.define do
  factory :hackday_organization do
    name Faker::Company.name
    after(:build) do |ho|
      ho.owners << User.last if ho.owners.empty?
    end
  end
end
