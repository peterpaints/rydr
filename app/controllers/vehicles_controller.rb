# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action :require_login

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      vehicle_save_success
    else
      flash[:danger] = @vehicle.errors.full_messages.to_sentence
      redirect_to profile_path
    end
  end

  def edit
  end

  private

  def vehicle_save_success
    flash[:success] = 'Changes saved!'
    redirect_to profile_path
  end

  def vehicle_params
    params.require(:vehicle).permit(:make, :model, :license_plate,
                                    :capacity, :color)
          .merge(user_id: current_user)
  end
end
