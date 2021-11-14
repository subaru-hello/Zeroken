class Alcohol < ApplicationRecord
  has_many :alcohol_orders, dependent: :destroy
  scope :semi_weak, -> { where(' alcohol_percentage < ? ', 5.10) }
  scope :weak, -> { where(' alcohol_percentage < ? ', 8.05) }

  scope :semi_strong,
        -> { where('alcohol_percentage > ? and alcohol_percentage < ? ', 5.00, 13.01) }
  scope :strong, -> { where('alcohol_percentage > ? and alcohol_percentage < ? ', 8.00, 40.01) }

  scope :selected, -> { select('id,name,description, alcohol_percentage') }
  # scopeを定義
  # strong
  # order_byを使って、alcohol_percentageが５％から１０個取り出し、ランダムで提供する。

  # normal

  # weakも設定する。
end
