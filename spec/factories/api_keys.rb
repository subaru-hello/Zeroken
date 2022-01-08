FactoryBot.define do
  factory :api_key do
    user { nil }
    access_token { "MyString" }
    expired_at { "2022-01-08 11:15:06" }
  end
end
