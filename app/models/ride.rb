# frozen_string_literal: true

class Ride < ApplicationRecord
  include Exceptions

  has_and_belongs_to_many :users, before_add: %i[ride_owner_cannot_book
                                                 cannot_book_full_ride]
  belongs_to :vehicle

  VALID_CAPACITY = /[1-9]/

  validates :origin, :destination, :departure_time, :capacity, :vehicle_id,
            presence: true

  validates :vehicle_id,
            uniqueness: { scope: :departure_time,
                          message: 'That ride already exists.' }

  validates :capacity,
            format: { with: VALID_CAPACITY }

  def booked?(user)
    users.include? user
  end

  def ride_owner_cannot_book(user)
    raise OwnerBooking if user.vehicles.include? vehicle
  end

  def cannot_book_full_ride(_user)
    raise RideFull if users.size == capacity
  end
end
