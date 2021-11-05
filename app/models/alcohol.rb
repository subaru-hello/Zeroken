class Alcohol < ApplicationRecord
  has_many :alcohol_orders, dependent: :destroy
  scope :random_weak, ->{ self.where('alcohol_percentage < ?', 7).shuffle[0..4] }

  scope :random_strong, ->{ self.where('alcohol_percentage > ?', 7).shuffle[0..4]  }
  # scopeを定義
  # strong
  # order_byを使って、alcohol_percentageが５％から１０個取り出し、ランダムで提供する。

  # normal

  # weakも設定する。
end
