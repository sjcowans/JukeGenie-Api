class SuggestionSerializer
  include JSONAPI::Serializer
  attributes :media_type, :request, :user_id, :playlist_id, :spotify_artist_id, :track_artist
end