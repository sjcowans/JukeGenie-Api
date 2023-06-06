class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :email, :token, :spotify_id
end
