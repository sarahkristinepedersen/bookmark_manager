FactoryGirl.define do
  factory :user do
    email "alice@example.com"
    password "12345"
    password_confirmation "12345"
  end
end