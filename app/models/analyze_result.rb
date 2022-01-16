class AnalyzeResult < ApplicationRecord
  belongs_to :user
  has_many :descriptions
  belongs_to :alcohol_in_vein
end
