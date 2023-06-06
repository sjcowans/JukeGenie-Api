class ChangeSuggestions < ActiveRecord::Migration[7.0]
  def change
    change_column :suggestions, :type, :integer
    rename_column :suggestions, :type, :seed_type
    add_column :suggestions, :spotify_track_id, :string
  end
end
