class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.float :longitude
      t.float :latitude
      t.string :input_address
      t.float :range, default: 0
      t.string :spotify_id

      t.timestamps
    end
  end
end
