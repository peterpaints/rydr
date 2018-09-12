# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
    redirect_to rides_path if current_user
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      login_success
    else
      flash[:danger] = 'Invalid email or password.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user] = nil
    redirect_to login_path
  end

  private

  def login_success
    session[:user] = @user.id
    redirect_to rides_path
  end
end
