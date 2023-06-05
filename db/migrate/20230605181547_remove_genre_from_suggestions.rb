class RemoveGenreFromSuggestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :suggestions, :genre, :integer
  end
end
