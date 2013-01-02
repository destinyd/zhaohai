# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :userinfo do
    realname "someone"
    gender :female
    status "nothing"
    home "home"
    now "near home"
    birth "1990-12-26"
    work "with computer"
    school "school"

    trait :male do
      realname "male"
      gender :male
    end

    trait :female do
      realname "female"
      gender :female
    end

    trait :richman do
      male
      realname "richman"
      status "i am very rich"
    end
  end
end
