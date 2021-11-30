class Analyze < ApplicationRecord
  belongs_to :user
  has_many :alcohol_analyzes, dependent: :destroy
  has_many :alcohols, through: :alcohol_analyzes
  enum next_nomivation_types: { flesh: 0, tipsy: 1, heavy_drunk: 2 }
  enum sake_strongness_types: { weak: 0, normal: 1, strong: 2 }
end
