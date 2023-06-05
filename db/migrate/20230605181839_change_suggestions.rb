class ChangeSuggestions < ActiveRecord::Migration[7.0]
  def change
    change_column :suggestions, :type, :integer
  end
end
