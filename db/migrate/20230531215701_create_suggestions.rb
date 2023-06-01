class CreateSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :suggestions do |t|
      t.integer :genre
      t.string :type
      t.string :request
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
