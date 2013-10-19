require 'factory_girl'

FactoryGirl.define do
  factory :project do
    name Faker::Commerce.product_name
    description 'A lonnnnggggg description'
  end
end
