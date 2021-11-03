class AlcoholOrder < ApplicationRecord
  belongs_to :analyze
  has_many :alcohols, as: :alcoholable, dependent: :destroy
end
