class AlcoholInVein < ApplicationRecord
  has_many :analyze_results, dependent: :destroy
end
