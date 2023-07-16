# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to root_path, notice: "Welcome back, #{current_user.name}" if current_user

    return unless request.post?

    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'You have signed in successfully.'
    else
      redirect_to login_path, alert: 'Invalid Credentials'
    end
  end

  def create; end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: 'You have logged out.'
  end
end
