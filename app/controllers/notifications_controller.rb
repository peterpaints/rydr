# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :require_login
  before_action :find_current_user, only: %i[mark_as_read]

  def create
    @notification = Notification.new(notification_params)
    notification_save_error(@notification) unless @notification.save
  end

  def mark_as_read
    @user.notifications.where(read: false).each do |notification|
      notification.update(read: true)
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def find_current_user
    @user = User.find(current_user)
  end

  def notification_save_error(notification)
    notification.errors.each do |_attr, message|
      flash[:danger] = message
    end
    redirect_to user_path(current_user)
  end

  def notification_params
    params.require(:notification).permit(:message)
  end
end
