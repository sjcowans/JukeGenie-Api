class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :spotify_id
      t.float :range
      t.string :input_address
      t.float :longitude
      t.float :latitude
      t.references :host, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
