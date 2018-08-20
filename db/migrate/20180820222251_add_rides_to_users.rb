class AddRidesToUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :rides, :users do |t|
      t.index [:ride_id, :user_id]
    end
  end
end
