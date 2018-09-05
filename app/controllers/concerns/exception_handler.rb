# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from RideExceptions::OwnerBooking, with: :ride_booking_error
    rescue_from RideExceptions::RideFull, with: :ride_full_error
    rescue_from RideExceptions::VehicleOverload, with: :vehicle_overload_error
    rescue_from RideExceptions::InvalidTime, with: :invalid_time_error
    rescue_from RideExceptions::RiderLacksSeating, with:
                                                   :rider_lacks_seating_error
  end

  private

  def ride_booking_error
    flash[:danger] = 'You can not book a ride you own.'
    redirect_to rides_path
  end

  def ride_full_error
    flash[:danger] = 'Sorry, ride\'s full.'
    redirect_to rides_path
  end

  def vehicle_overload_error
    flash[:danger] = 'Sorry, ride capacity cannot be greater than vehicle
    capacity.'
    redirect_to user_path(current_user.id)
  end

  def invalid_time_error
    flash[:danger] = 'Rides should be at least 3 minutes from now.'
    redirect_to user_path(current_user.id)
  end

  def rider_lacks_seating_error
    flash[:danger] = 'Some rider(s) will lack seats.'
    redirect_to user_path(current_user.id)
  end
end
