class AnalyzeSerializer
  include JSONAPI::Serializer
  set_type :analyze
  attributes :total_points, :alcohol_strongness, :next_motivation, :description, :shuchedule
  belongs_to :user
  has_many :my_shuchedules
end
