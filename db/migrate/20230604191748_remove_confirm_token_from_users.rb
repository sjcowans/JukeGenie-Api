class RemoveConfirmTokenFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :confirm_token, :string
  end
end
