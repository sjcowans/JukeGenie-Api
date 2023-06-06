class TrackSerializer
  include JSONAPI::Serializer
  attributes :name, :spotify_track_id
end