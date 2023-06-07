class PlaylistSerializer
  include JSONAPI::Serializer
  attributes :name, :spotify_id, :longitude, :latitude, :input_address, :spotify_id, :range
end
