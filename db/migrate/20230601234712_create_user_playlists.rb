class CreateUserPlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :user_playlists do |t|
      t.references :user, foreign_key: true
      t.references :playlist, foreign_key: true
      t.boolean :host

      t.timestamps
    end
  end
end
