class DeleteProfileTypeFromAccounts < ActiveRecord::Migration[5.1]
  def change
    remove_column :accounts, :profileType
  end
end