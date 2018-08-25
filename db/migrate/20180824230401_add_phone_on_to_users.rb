class AddPhoneOnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone_on, :boolean, default: false
  end
end
