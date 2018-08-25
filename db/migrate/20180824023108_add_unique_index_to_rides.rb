class AddUniqueIndexToRides < ActiveRecord::Migration[5.2]
  def change
    add_index :rides, [:departure_time, :vehicle_id], unique: true
  end
end
