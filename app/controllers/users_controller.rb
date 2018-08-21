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
      flash[:danger] = @user.errors.full_messages.to_sentence
      redirect_to login_path
    end
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    restricted_access unless @user.id == logged_in?
  end

  private

  def user_save_success
    session[:user] = @user.id
    redirect_to user_path(@user.id)
  end

  def restricted_access
    flash[:danger] = "You can't view that page"
    redirect_to rides_path
  end

  def user_params
    params.require(:user).permit(:email, :password, :confirm)
  end
end
