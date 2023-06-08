class PlaylistSerializer
  include JSONAPI::Serializer
  attributes :name, :longitude, :latitude, :input_address, :spotify_id, :range, :join_key, :host_id
end
