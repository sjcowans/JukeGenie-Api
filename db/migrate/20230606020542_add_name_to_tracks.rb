class AddNameToTracks < ActiveRecord::Migration[7.0]
  def change
    add_column :tracks, :name, :string
  end
end
