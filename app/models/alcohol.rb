class Alcohol < ApplicationRecord
  has_many :alcohol_orders, dependent: :destroy

  #scopeを定義
  #strong
  #order_byを使って、alcohol_percentageが５％から１０個取り出し、ランダムで提供する。

  #normal

  #weakも設定する。

end
