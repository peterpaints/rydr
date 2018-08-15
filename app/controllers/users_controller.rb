# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      user_save_success
    else
      p @user.errors.full_messages.to_sentence
      flash[:danger] = @user.errors.full_messages.to_sentence
      redirect_to login_path
    end
  end

  def edit
  end

  private

  def user_save_success
    session[:user] = @user.id
    redirect_to profile_path
  end

  def user_params
    params.require(:user).permit(:email, :password, :confirm)
  end
end
