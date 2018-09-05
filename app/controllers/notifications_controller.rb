# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :require_login

  def create
    @notification = Notification.new(notification_params)
    notification_save_error(@notification) unless @notification.save
  end

  def mark_as_read
    current_user.notifications.where(read: false).update_all(read: true)

    respond_to do |format|
      format.js
    end
  end

  private

  def notification_save_error(notification)
    notification.errors.each do |_attr, message|
      flash[:danger] = message
    end
    redirect_to user_path(current_user.id)
  end

  def notification_params
    params.require(:notification).permit(:message)
  end
end
