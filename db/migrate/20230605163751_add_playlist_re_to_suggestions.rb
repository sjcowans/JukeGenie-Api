class AddPlaylistReToSuggestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :suggestions, :playlist, null: false, foreign_key: true
  end
end
