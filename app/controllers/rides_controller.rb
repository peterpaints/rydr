# frozen_string_literal: true

class RidesController < ApplicationController
  before_action :require_login

  def index
    @user = User.find(current_user)
  end

  def create
    @ride = Ride.new(ride_params)
    flash[:danger] = @ride.errors.full_messages.to_sentence unless @ride.save
  end

  def edit
  end

  private

  def restricted_access
    flash[:danger] = "You can't view that page"
    redirect_to rides_path
  end

  def ride_params
    params.require(:ride).permit(:destination, :origin, :capacity,
                                 :departure_time, :vehicle_id)
  end
end
