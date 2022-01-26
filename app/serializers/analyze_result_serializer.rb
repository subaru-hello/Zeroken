class AnalyzeResultSerializer
  include JSONAPI::Serializer
  set_type :analyze_result
  attributes :total_points,
             :alcohol_strongness,
             :next_motivation,
             :total_alcohol_amounts,
             :description
  belongs_to :user
end
