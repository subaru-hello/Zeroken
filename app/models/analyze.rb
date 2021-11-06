class Analyze < ApplicationRecord
  belongs_to :user
  has_many :alcohol_orders, dependent: :destroy
  enum next_nomivation_types: { flesh: 0, tipsy: 1, heavy_drunk: 2 }
  enum sake_strongness_types: { weak: 0, normal: 1, strong: 2 }
  scope :sorted, -> { order(created_at: :desc) }
end
