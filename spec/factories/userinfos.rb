# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :userinfo do
    realname "someone"
    gender true
    status "nothing"
    home "home"
    now "near home"
    birth "1990-12-26"
    work "with computer"
    school "school"

    trait :male do
      realname "male"
      gender false
    end

    trait :female do
      realname "female"
      gender true
    end

    trait :richman do
      male
      realname "richman"
      status "i am very rich"
    end
  end
end
