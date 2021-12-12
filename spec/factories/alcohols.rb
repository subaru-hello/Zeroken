FactoryBot.define do
  factory :alcohol do  
      sequence(:name) { |n| "alcohol_#{n}" }
      alcohol_amount { '350' }
      alcohol_percentage { '6' }
      description { 'お酒の説明が記載されている場所になります。' }
  end
end
