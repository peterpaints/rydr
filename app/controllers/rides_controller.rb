# frozen_string_literal: true

class RidesController < ApplicationController
  before_action :require_login

  def index
    @user = User.find(current_user)
  end

  def create
    @ride = Ride.new(ride_params)
    if @ride.save
      ride_save_success
    else
      ride_save_error(@ride)
    end
  end

  def edit
  end

  private

  def restricted_access
    flash[:danger] = "You can't view that page"
    redirect_to rides_path
  end

  def ride_save_success
    flash[:success] = 'Ride created!'
    redirect_to user_path(current_user)
  end

  def ride_save_error(ride)
    ride.errors.each do |attr, message|
      flash[:danger] = message
    end
    redirect_to user_path(current_user)
  end

  def ride_params
    params.require(:ride).permit(:destination, :origin, :capacity,
                                 :departure_time, :vehicle_id)
  end
end
