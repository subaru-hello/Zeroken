FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "test_user#{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'password' }
    password_conformation { 'password' }
  end
end
