class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    find_or_create_user
    # this is not realistic, but I wont create a signup form in this assigment.
    # So let's assume the user is already registered and we just need to authenticate them.

    if user = User.authenticate_by(user_params)
      start_new_session_for user
      if @new_record
        flash[:notice] = "Welcome! You have successfully signed up."
      end

      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Wrong email or password."
    end
  end

  def destroy
    terminate_session
    redirect_to root_path, notice: "You have been logged out."
  end

  private

  def user_params
    params.permit(:email_address, :password)
  end

  def find_or_create_user
    User.find_or_create_by(email_address: user_params[:email_address]) do |user|
      user.password = user_params[:password]
      user.password_confirmation = user_params[:password]
      @new_record = true
    end
  rescue ActiveRecord::RecordNotUnique
    User.find_by(email_address: user_params[:email_address])
  end
end
