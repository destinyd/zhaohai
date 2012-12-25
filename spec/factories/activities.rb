# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    title "MyString"
    desc "MyString"
    lat 1.0
    lng 2.0
    user_id 1
    started_at "2012-12-25 14:57:18"
    finished_at "2012-12-25 14:57:18"
  end
end
