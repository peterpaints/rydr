class AddReferencesToRides < ActiveRecord::Migration[5.2]
  def change
    add_reference :rides, :vehicle, foreign_key: true, index: true
  end
end
