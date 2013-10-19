# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album do
    title "MyString"
    association :user, :factory => :user
  end
end
