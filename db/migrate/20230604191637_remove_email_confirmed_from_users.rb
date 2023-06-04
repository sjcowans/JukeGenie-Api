class RemoveEmailConfirmedFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :email_confirmed, :boolean
  end
end
