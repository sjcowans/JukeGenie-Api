class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.float :longitude
      t.float :latitude
      t.string :input_address
      t.float :range

      t.timestamps
    end
  end
end
