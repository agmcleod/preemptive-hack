require 'factory_girl'

FactoryGirl.define do
  factory :hackday_organization do
    name Faker::Company.name
    after(:build) do |ho|
      ho.owners << User.guest_account
    end

    before(:create) do |ho|
      ho.owners << User.guest_account
    end
  end
end
