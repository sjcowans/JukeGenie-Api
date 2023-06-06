class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :spotify_id
      t.text :genres
      t.integer :popularity
      t.json :images

      t.timestamps
    end
  end
end
