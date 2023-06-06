class ChangeSuggestions < ActiveRecord::Migration[7.0]
  def change
    change_column :suggestions, :type, :integer
    rename_column :suggestions, :type, :media_type
  end
end
