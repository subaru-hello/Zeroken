class Analyze < ApplicationRecord
  belongs_to :user
  has_many :alcohol_analyzes, dependent: :destroy
  has_many :alcohols, through: :alcohol_analyzes
  enum next_motivation: { flesh: 0, tipsy: 1, heavy_drunk: 2 }
  enum alcohol_strongness: { weak: 0, normal: 1, strong: 2 }
end
