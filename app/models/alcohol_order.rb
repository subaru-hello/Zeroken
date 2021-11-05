class AlcoholOrder < ApplicationRecord
  belongs_to :analyze
  belongs_to :alcohol
end
