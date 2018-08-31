# frozen_string_literal: true

class RidesController < ApplicationController
  include Notifications
  include FilterSearch

  before_action :require_login
  before_action :find_ride, only: %i[book cancel update destroy]
  before_action :find_current_user, only: %i[index book cancel]

  rescue_from Exceptions::OwnerBooking, with: :ride_booking_error
  rescue_from Exceptions::RideFull, with: :ride_full_error
  rescue_from Exceptions::VehicleOverload, with: :vehicle_overload_error
  rescue_from Exceptions::InvalidTime, with: :invalid_time_error
  rescue_from Exceptions::RiderLacksSeating, with: :rider_lacks_seating_error

  def index
    @rides = Ride.where('departure_time > ?', Time.now).order(created_at: :desc)
    filter_rides(params) if params[:filter] || params[:destination]
  end

  def create
    @ride = Ride.new(ride_params)
    if @ride.save
      ride_save_success
    else
      ride_save_error(@ride)
    end
  end

  def update
    if @ride.update(ride_params)
      @ride.users.each do |user|
        notify(user, update_message(@ride))
      end
      ride_save_success
    else
      ride_save_error(@ride)
    end
  end

  def book
    @ride.users << @user
    notify(@ride.vehicle.user, book_message(@ride, @user))
    flash[:success] = 'Ride booked!'
    redirect_to rides_path
  end

  def cancel
    @ride.users.delete(@user)
    notify(@ride.vehicle.user, cancel_message(@ride, @user))
    flash[:success] = 'Ride cancelled. What\'s up?'
    redirect_to rides_path
  end

  def destroy
    if @ride.destroy
      @ride.users.each do |user|
        notify(user, destroy_message(@ride))
      end
      ride_save_success('Ride deleted. Now we have to walk?')
    else
      ride_save_error(@ride)
    end
  end

  private

  def find_ride
    @ride = Ride.find(params[:id])
  end

  def find_current_user
    @user = User.find(current_user)
  end

  def ride_save_success(message = nil)
    flash[:success] = message || 'Ride saved!'
    redirect_to user_path(current_user)
  end

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
    redirect_to user_path(current_user)
  end

  def invalid_time_error
    flash[:danger] = 'Rides should be at least 3 minutes from now.'
    redirect_to user_path(current_user)
  end

  def rider_lacks_seating_error
    flash[:danger] = 'Some rider(s) will lack seats.'
    redirect_to user_path(current_user)
  end

  def ride_save_error(ride)
    ride.errors.each do |_attr, message|
      flash[:danger] = message
    end
    redirect_to user_path(current_user)
  end

  def ride_params
    params.require(:ride).permit(:destination, :origin, :capacity,
                                 :departure_time, :vehicle_id)
  end

  def search_params(params)
    params.slice(:destination)
  end
end
