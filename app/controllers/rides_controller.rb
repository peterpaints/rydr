# frozen_string_literal: true

class RidesController < ApplicationController
  before_action :require_login
  before_action :find_ride, only: [:book, :cancel, :update, :destroy]
  before_action :find_current_user, only: [:index, :book, :cancel]

  rescue_from Exceptions::InvalidBooking, with: :ride_booking_error

  def index
    @rides = Ride.all
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
      ride_save_success
    else
      ride_save_error(@ride)
    end
  end

  def book
    @ride.users << @user
    flash[:success] = 'Ride booked!'
    redirect_to rides_path
  end

  def cancel
    @ride.users.delete(@user)
    flash[:success] = 'Ride cancelled. What\'s up?'
    redirect_to rides_path
  end

  def destroy
    if @ride.destroy
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
end
