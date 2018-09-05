# frozen_string_literal: true

class Ride < ApplicationRecord
  include RideExceptions

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

  before_save :ride_capacity_not_more_than_vehicle,
              :departure_time_cannot_be_past,
              :invalid_capacity_update

  scope :available_rides, lambda {
    includes(:users)
      .where('departure_time > ?', Time.now)
      .order(created_at: :desc)
  }

  scope :filter_by_user, lambda { |user|
    joins(:users)
      .where(users: { id: user.id })
      .order(created_at: :desc)
  }

  scope :destination, lambda { |destination|
    where('lower(destination) like ?',
          "%#{destination.downcase}%")
  }

  def booked?(user)
    users.include? user
  end
end
