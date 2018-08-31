class AddReferencesToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :user, foreign_key: true, index: true
  end
end
