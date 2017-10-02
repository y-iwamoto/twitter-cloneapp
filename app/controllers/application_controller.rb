class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def after_sign_in_path_for(resource)
    if cookies[:auth_token]
      home_path
    else
      reset_session
      new_user_session_path
    end
  end
  protect_from_forgery with: :exception
end
