class AddSpotifyArtistIdToSuggestions < ActiveRecord::Migration[7.0]
  def change
    add_column :suggestions, :spotify_artist_id, :string, :default => nil
    add_column :suggestions, :track_artist, :string, :default => nil
  end
end
