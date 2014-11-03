FactoryGirl.define do
  factory :user do
    username Faker::Internet.user_name
    password Faker::Internet.password
  end
  
  factory :other_user, class: User do
    username Faker::Internet.user_name
    password Faker::Internet.password
  end
end
