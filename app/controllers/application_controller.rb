class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :current_notifications, if: :signed_in?

  def current_notifications
    @notifications_count = Notification.where(user_id: current_user.id).where(read: false).count
  end

  def after_sign_in_path_for(resource)
    if cookies[:auth_token]
      home_path
    else
      reset_session
      new_user_session_path
    end
  end
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update){ |u| u.permit(:name, :email,:current_password,:password, :password_confirmation,:self_introduction,:place,:homepage_url,:birthday,:image) }
    end
end
