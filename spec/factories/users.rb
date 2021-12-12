FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "test_user#{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }

    trait :nickname_invalid do
      nickname { nil }
    end
    trait :login do
      nickname { "user1" }
      email { "user1@example.com" }
      password { 'password' }
      password_confirmation { 'password' }
    end

    trait :email_invalid do
      email { nil }
    end

    trait :password_invalid do
      password { nil }
    end

  end
end
