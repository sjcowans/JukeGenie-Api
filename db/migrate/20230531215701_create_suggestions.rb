class CreateSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :suggestions do |t|
      t.string :genre
      t.string :artist_id
      t.string :artist_name
      t.string :song_id
      t.string :song_name
      t.string :playlist_id
      t.string :user_id

      t.timestamps
    end
  end
end
