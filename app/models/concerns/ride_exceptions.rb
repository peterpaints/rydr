# frozen_string_literal: true

module RideExceptions
  extend ActiveSupport::Concern

  class OwnerBooking < StandardError; end
  class RideFull < StandardError; end
  class VehicleOverload < StandardError; end
  class InvalidTime < StandardError; end
  class RiderLacksSeating < StandardError; end

  included do
    def ride_owner_cannot_book(user)
      raise OwnerBooking if user.vehicles.include? vehicle
    end

    def cannot_book_full_ride(_user)
      raise RideFull if users.size == capacity
    end

    def ride_capacity_not_more_than_vehicle
      raise VehicleOverload if capacity > vehicle.capacity
    end

    def departure_time_cannot_be_past
      raise InvalidTime if departure_time < Time.now.localtime + 3.minutes
    end

    def invalid_capacity_update
      raise RiderLacksSeating if users.any? && capacity < users.size
    end
  end
end
