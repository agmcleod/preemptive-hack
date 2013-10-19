require 'factory_girl'

FactoryGirl.define do
  factory :hackday do
    start_date Time.now + 5.days
  end
end
