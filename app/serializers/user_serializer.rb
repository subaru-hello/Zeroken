class UserSerializer
  include JSONAPI::Serializer
  set_type :user
  attributes :nickname, :email, :role
  has_many :analyze_results

  # attribute :avatar do |object|
  #   object.avatar.url
  # end
end
