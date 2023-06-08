class PlaylistSerializer
  include JSONAPI::Serializer
  attributes :name, :longitude, :latitude, :input_address, :spotify_id, :range
end
