class UserSerializer
  include JSONAPI::Serializer
  set_type :user
  attributes :nickname, :email, :role
  has_many :analyzes

  # attribute :avatar do |object|
  #   object.avatar.url
  # end
end
