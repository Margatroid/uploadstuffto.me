FactoryGirl.define do
  sequence :email do |n|
    "user#{ n }@gmail.com"
  end

  sequence :username do |n|
    "test_user#{ n }"
  end

  sequence :key do |n|
    "ThisIsAnInviteKey#{ n }"
  end

  sequence :description do |n|
    "This is a description for invite #{ n }"
  end

  factory :invite do
    key
    description
  end

  factory :user do
    invite
    username
    email
    password 'helloworld'
    password_confirmation { |u| u.password }
  end
end