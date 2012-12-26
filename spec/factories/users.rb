# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
    userinfo {FactoryGirl.build(:userinfo) }
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
    factory :richman do
      name 'richman'
      email 'richman@example.com'
      userinfo {FactoryGirl.build(:userinfo,:richman)}
    end

    trait :male do
      userinfo {FactoryGirl.build(:userinfo,:male) }
    end

    trait :female do
      userinfo {FactoryGirl.build(:userinfo,:female) }
    end
  end
end
