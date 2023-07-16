# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
    return unless request.post?

    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome to Wildfire, #{@user.name}"
    else
      render :new, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
