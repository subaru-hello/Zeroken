class Alcohol < ApplicationRecord
  belongs_to :alcohol_order
  belongs_to :alcoholable, polymorphic: true
  enum alcohol_types: { beer: 0, shotyu: 1, nihonshu: 2, wine: 3, tyuhai: 4, wiskey: 5 }
end
