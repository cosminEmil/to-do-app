class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def home
  end
  # Custom method to check if a user is logged in
  def authenticate_user!
    redirect_to root_path, alert: "You need to log in first." unless current_user
  end
  # Retrieves the currently logged-in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
