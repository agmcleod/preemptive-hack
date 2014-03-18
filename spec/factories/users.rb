FactoryGirl.define do
  factory :user do
    sequence(:username) { |i| "#{Faker::Internet.user_name}-#{i}" }
    sequence(:email) { |i| "#{i}-#{Faker::Internet.email}" }
  end
end
