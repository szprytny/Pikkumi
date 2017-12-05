class CreateVerificationCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :verification_codes do |t|
      t.string :code
      t.integer :accountId

      t.timestamps
    end
  end
end
