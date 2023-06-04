class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :email, :token, :role, :spotify_id
end
