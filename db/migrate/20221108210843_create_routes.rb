class CreateRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :routes do |t|
      t.string :uuid
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :travel_time
      t.integer :total_stops
      t.string :action

      t.references :organization, null: false, foreign_key: true
      t.references :vehicle, foreign_key: true

      t.timestamps
    end
  end
end
