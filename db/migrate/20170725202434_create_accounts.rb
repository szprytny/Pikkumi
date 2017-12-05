class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :password_encoded
      t.string :password_salt
      t.string :email
      t.boolean :isVerified
      t.integer :profileType
      t.string :avatarURI

      t.timestamps
    end
  end
end
