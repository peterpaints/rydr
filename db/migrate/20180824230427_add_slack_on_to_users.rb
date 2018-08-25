class AddSlackOnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :slack_on, :boolean, default: false
  end
end
