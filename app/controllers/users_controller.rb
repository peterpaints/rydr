# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :show]
  before_action :set_user, only: [:show, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      user_save_success
    else
      user_save_error(@user, login_path)
    end
  end

  def show
    restrict_access unless @user.id == current_user
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Settings updated!'
      redirect_to user_path(current_user)
    else
      user_save_error(@user, user_path(current_user))
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_save_success
    session[:user] = @user.id
    redirect_to user_path(@user.id)
  end

  def user_save_error(user, path)
    user.errors.each do |_attr, message|
      flash[:danger] = message
    end
    redirect_to path
  end

  def restrict_access
    flash[:danger] = "You can't view that page"
    redirect_to rides_path
  end

  def user_params
    params.require(:user).permit(:email, :password, :confirm, :phone_number,
                                 :slack_handle, :phone_on, :slack_on)
  end
end
