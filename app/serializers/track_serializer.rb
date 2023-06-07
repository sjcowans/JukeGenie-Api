class TrackSerializer
  include JSONAPI::Serializer
  attributes :name, :spotify_id
end