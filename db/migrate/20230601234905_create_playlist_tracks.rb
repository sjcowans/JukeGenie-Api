class CreatePlaylistTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :playlist_tracks do |t|
      t.references :playlist_id, foreign_key: true
      t.references :track_id, foreign_key: true

      t.timestamps
    end
  end
end
