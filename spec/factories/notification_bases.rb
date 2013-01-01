# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification_basis, :class => 'Notification::Base' do
    text "MyString"
  end
end
