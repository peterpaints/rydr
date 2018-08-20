class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.string :origin
      t.string :destination
      t.datetime :departure_time
      t.integer :capacity

      t.timestamps
    end
  end
end
