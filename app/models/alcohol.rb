class Alcohol < ApplicationRecord
  has_many :alcohol_orders, dependent: :destroy

  # 自己結合

  # 【前段部分】

  # 1000ボックスに属するliquor_idを取得するassociation
  has_many :liquor_relationships,
           class_name: 'Relationship',
           foreign_key: 'liquor_box_id',
           dependent: :destroy,
           inverse_of: :liquor

  # コーヒーが属するliquor_box_idを取得するassociation
  has_many :liquor_box_relationships,
           class_name: 'Relationship',
           foreign_key: 'liquor_id',
           dependent: :destroy,
           inverse_of: :liquor_box

  # 【後段部分】

  # 1000ボックスから焼酎、日本酒、ワインを取得する
  has_many :liquors, through: :liquor_relationships

  # ビールから1000ボックスを取得する
  has_many :liquor_boxes, through: :liquor_box_relationships

end
