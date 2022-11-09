class CreateDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers do |t|
      t.string :uuid
      t.string :first_name
      t.string :last_name
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
