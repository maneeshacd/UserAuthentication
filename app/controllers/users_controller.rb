class UsersController < ApplicationController
  skip_before_action :authorization, only: %i[new create]
  before_action :user_authenticated, only: :new

  def new
    @user = User.new
  end

  def profile; end

  def create
    @user = User.new(user_params)
    @user.email.downcase!
    @user.skip_username_validation = true
    if @user.save
      session[:user_id] = @user.id.to_s
      UserMailer.welcome_mail(@user).deliver_now
      redirect_to profile_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path, notice: 'User was successfully updated.'
    else
      render :profile
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username, :email, :password, :password_confirmation
    )
  end

  def user_authenticated
    redirect_to profile_path if current_user.present?
  end
end
