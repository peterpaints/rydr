# frozen_string_literal: true

class Ride < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :vehicle

  VALID_CAPACITY = /[0-9]/

  validates :origin, :destination, :departure_time, :capacity, :vehicle_id,
            presence: { message: 'Please enter every attribute.' }
  validates :vehicle_id,
            uniqueness: { scope: :departure_time, message: 'That ride already exists.' }
  validates :capacity,
            format: { with: VALID_CAPACITY, message: 'Invalid capacity format.' }
end
