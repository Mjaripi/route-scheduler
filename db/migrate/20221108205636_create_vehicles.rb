class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :uuid
      t.string :plate
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
