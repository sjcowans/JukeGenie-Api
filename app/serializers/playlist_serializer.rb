class PlaylistSerializer
  include JSONAPI::Serializer
  attributes :name, :spotify_id, :lon, :lat
end
