# frozen_string_literal: true

module ApplicationHelper
  def unauthorized
    flash[:danger] = "You're not authorized. Please Log In."
    redirect_to login_path
  end

  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

  def require_login
    return if current_user
    unauthorized
  end
end
