class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "You have signed in successfully."
    else
      redirect_to login_path, alert: "Invalid Credentials"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "You have signed out."
  end
end
