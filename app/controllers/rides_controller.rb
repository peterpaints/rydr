# frozen_string_literal: true

class RidesController < ApplicationController
  before_action :require_login
  before_action :find_ride, only: [:update, :destroy]

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

  def update
    if @ride.update(ride_params)
      ride_save_success
    else
      ride_save_error(@ride)
    end
  end

  def destroy
    if @ride.destroy
      ride_save_success('Oh no! Now we have to walk?')
    else
      ride_save_error(@ride)
    end
  end

  private

  def find_ride
    @ride = Ride.find(params[:id])
  end

  def ride_save_success(message=nil)
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
end
