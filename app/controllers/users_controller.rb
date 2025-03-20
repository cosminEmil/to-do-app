class UsersController < ApplicationController
  allow_unauthenticated_access
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if verify_recaptcha && @user.save
      session[:user_id] = @user.id # Log the user in
      redirect_to dashboard_path, notice: "Welcome! Your account has been created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end

end
