class CreateProfileAffiliations < ActiveRecord::Migration[5.1]
  def change
    create_table :profile_affiliations do |t|
      t.integer :profileTypeId
      t.integer :accountId

      t.timestamps
    end
  end
end
