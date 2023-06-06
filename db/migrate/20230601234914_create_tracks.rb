class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.string :spotify_track_id
      t.integer :popularity
      t.json :images

      t.timestamps
    end
  end
end
