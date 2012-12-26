# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    title "Drinking in bar"
    desc "I need a beauty"
    lat 1.0
    lng 2.0
    #user_id 1
    started_at DateTime.now
    #finished_at DateTime.now + 4.hours
    #factory :activity_by_rich do
      #ignore do
        #users_count 1
      #end

      #after(:create) do |user, evaluator|
        #FactoryGirl.create_list(:user, evaluator.users_count, user: user)
      #end
    #end
  end
end
