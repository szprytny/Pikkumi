class CreateProfileTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :profile_types do |t|
      t.string :typeName

      t.timestamps
    end
  end
end
