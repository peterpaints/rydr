# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action :require_login
  before_action :find_vehicle, only: %i[update destroy]

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      vehicle_save_success
    else
      vehicle_save_error(@vehicle)
    end
  end

  def update
    if @vehicle.update(vehicle_params)
      vehicle_save_success
    else
      vehicle_save_error(@vehicle)
    end
  end

  def destroy
    if @vehicle.destroy
      vehicle_save_success('Shame. It was a nice car.')
    else
      vehicle_save_error(@vehicle)
    end
  end

  private

  def find_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_save_success(message = nil)
    flash[:success] = message || 'Vehicle saved!'
    redirect_to user_path(current_user)
  end

  def vehicle_save_error(vehicle)
    vehicle.errors.each do |_attr, message|
      flash[:danger] = message
    end
    redirect_to user_path(current_user)
  end

  def vehicle_params
    params.require(:vehicle).permit(:make, :model, :license_plate,
                                    :capacity, :color)
          .merge(user_id: current_user)
  end
end
