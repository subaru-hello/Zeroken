FactoryBot.define do
  factory :analyze do
    total_points { '1' }
    alcohol_strongness { 'weak' }
    next_motivation {'tipsy'}
    description { '次の飲み会ではこの酒ジュールでいきましょう' }
    association :user
  end
end
