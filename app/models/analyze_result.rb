class AnalyzeResult < ApplicationRecord
belongs_to :users
has_many :descriptions
has_many :alcohol_in_veins
end
