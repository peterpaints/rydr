# frozen_string_literal: true

class RidesController < ApplicationController
  include ExceptionHandler
  include Notifications
  include FilterSearch

  before_action :require_login
  before_action :find_ride, only: %i[book cancel update destroy]

  def index
    @rides = Ride.available_rides
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
    @ride.users << current_user
    notify(@ride.vehicle.user, book_message(@ride, current_user))
    flash[:success] = 'Ride booked!'
    redirect_to rides_path
  end

  def cancel
    @ride.users.delete(current_user)
    notify(@ride.vehicle.user, cancel_message(@ride, current_user))
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

  def ride_save_success(message = nil)
    flash[:success] = message || 'Ride saved!'
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
