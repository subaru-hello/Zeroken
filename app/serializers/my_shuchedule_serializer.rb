class MyShucheduleSerializer
  include JSONAPI::Serializer
  set_type :my_shuchedule
  attributes :succeed_shuchedule, :succeed_alcohol_strongness
  belongs_to :analyze
end
