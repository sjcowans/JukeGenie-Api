class CreateSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :suggestions do |t|
      t.integer :seed_type
      t.string :request
      t.string :track_artist
      t.string :spotify_artist_id
      t.string :spotify_track_id
      t.references :user, null: false, foreign_key: true
      t.references :playlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
