# frozen_string_literal: true

module Notifications
  extend ActiveSupport::Concern

  def notify(user, method)
    user.notifications.create(message: method)
  end

  def update_message(ride)
    "#{ride.vehicle.user.email.split('@')[0]} updated the
    details of their ride offer (#{ride.origin} to #{ride.destination})."
  end

  def book_message(ride, rider)
    "#{rider.email.split('@')[0]} booked your
    ride (#{ride.origin} to #{ride.destination})."
  end

  def cancel_message(ride, rider)
    "#{rider.email.split('@')[0]} cancelled your
    ride (#{ride.origin} to #{ride.destination})."
  end

  def destroy_message(ride)
    "#{ride.vehicle.user.email.split('@')[0]} deleted their
    ride offer (#{ride.origin} to #{ride.destination})."
  end
end
