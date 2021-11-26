class Relationship < ApplicationRecord
  belongs_to :liquor, class_name: 'Alcohol'
  belongs_to :liquor_box, class_name: 'Alcohol'
end
