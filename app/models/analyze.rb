class Analyze < ApplicationRecord
  belongs_to :user
  enum drunk_types: { flesh: 0, tipsy: 1, heavy_drunk: 2 }
  enum resistance_types: { normal: 0, weak: 1, strong: 2 }
end
