# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action :require_login

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(user_params)
    if @vehicle.save
      vehicle_save_success
    else
      p @vehicle.errors.full_messages.to_sentence
      flash[:danger] = @vehicle.errors.full_messages.to_sentence
      redirect_to profile_path
    end
  end

  def edit
  end

  private

  def vehicle_save_success
    @user = User.find(session[:user])
    @user.vehicles << @vehicle
    redirect_to profile_path
  end

  def vehicle_params
    params.require(:vehicle).permit(:make, :model, :license_plate,
                                    :capacity, :color)
  end
end
