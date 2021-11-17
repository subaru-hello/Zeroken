FactoryBot.define do
  factory :alcohol_order do
    order {'2'}
    association :alcohol
    association :analyze
  end
end
