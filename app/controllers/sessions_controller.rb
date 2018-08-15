# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to rides_path if logged_in?
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      session[:user] = @user.id
      redirect_to rides_path
    else
      p 'Invalid email or password.'
      flash[:danger] = 'Invalid email or password.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user] = nil
    redirect_to login_path
  end
end
