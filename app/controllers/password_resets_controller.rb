class PasswordResetsController < ApplicationController
  skip_before_action :authorization

  def new; end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to new_password_reset_url,
                alert: 'Email sent with password reset instructions.'
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 6.hours.ago
      redirect_to new_password_reset_path, alert: 'Password reset has expired.'
    elsif @user.update_attributes(user_params)
      redirect_to root_url, alert: 'Password has been reset.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
