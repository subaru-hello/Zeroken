FactoryBot.define do
  factory :analyze do
    total_points { '1' }
    sake_strongness_types { 'weak' }
    next_nomivation_types {'tipsy'}
    description { '次の飲み会ではこの酒ジュールでいきましょう' }
    association :user
  end
end
