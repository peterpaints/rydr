# frozen_string_literal: true

class RidesController < ApplicationController
  before_action :require_login

  def new
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)
    if @ride.save
      redirect_to rides_path
    else
      flash[:danger] = @ride.errors.full_messages.to_sentence
      redirect_to login_path
    end
  end

  def edit
  end

  def show
    @user = User.find(logged_in?)
  end

  private

  def restricted_access
    flash[:danger] = "You can't view that page"
    redirect_to rides_path
  end

  def user_params
    params.require(:ride).permit(:destination, :origin, :capacity,
                                 :departure_time, :vehicle_id)
  end
end
