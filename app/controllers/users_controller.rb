# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      user_save_success
    else
      user_save_error(@user)
    end
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    restrict_access unless @user.id == current_user
  end

  private

  def user_save_success
    session[:user] = @user.id
    redirect_to user_path(@user.id)
  end

  def user_save_error(user)
    user.errors.each do |attr, message|
      flash[:danger] = message
    end
    redirect_to login_path
  end

  def restrict_access
    flash[:danger] = "You can't view that page"
    redirect_to rides_path
  end

  def user_params
    params.require(:user).permit(:email, :password, :confirm)
  end
end
