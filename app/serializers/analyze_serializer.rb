class AnalyzeSerializer
    include JSONAPI::Serializer
    set_type :analyze
    attributes :total_points, :drunk_types, :resistance_types
    belongs_to :user
  end
  