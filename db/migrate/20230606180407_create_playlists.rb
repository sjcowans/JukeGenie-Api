class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :spotify_id
      t.float :lon
      t.float :lat

      t.timestamps
    end
  end
end