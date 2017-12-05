class AddRememberTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :remember_token, :string
    add_index  :accounts, :remember_token, unique: true
  end
end