class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :email, :token, :role, :spotify_id, :email_confirmed, :confirm_token
end
