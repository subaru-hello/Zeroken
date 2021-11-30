FactoryBot.define do
  factory :alcohol_analyze do
    order {'2'}
    association :alcohol
    association :analyze
  end
end
