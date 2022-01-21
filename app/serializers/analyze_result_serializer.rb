class AnalyzeResultSerializer
  include JSONAPI::Serializer
  set_type :analyze_result
  attributes :total_points, :alcohol_strongness, :next_motivation, :total_alcohol_amounts, :alcohol_first,
             :alcohol_second, :alcohol_third, :alcohol_forth
  belongs_to :user
  has_many :alcohol_in_veins
  has_many :desctiptions
end
