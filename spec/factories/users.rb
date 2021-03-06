# Read about factories at https://github.com/thoughtbot/factory_girl
require 'random_data'
FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "#{n}_#{Random.name}"}
    sequence(:email) {|n| "#{n}_#{Random.email}"}
    password 'please'
    password_confirmation 'please'
    userinfo {FactoryGirl.build(:userinfo) }
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
    trait :male do
      userinfo {FactoryGirl.build(:userinfo,:male) }
    end

    trait :female do
      userinfo {FactoryGirl.build(:userinfo,:female) }
    end

    factory :richman do
      male
      name 'richman'
      email 'richman@example.com'
      userinfo {FactoryGirl.build(:userinfo,:richman)}
    end

    factory :girl do
      female
      name 'girl'
    end

  end
end
