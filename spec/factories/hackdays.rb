require 'factory_girl'

FactoryGirl.define do
  factory :hackday do
    name { Faker::Commerce.product_name }
    start_date Time.now + 5.days
  end
end
