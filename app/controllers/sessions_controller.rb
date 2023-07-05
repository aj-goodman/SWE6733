class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to root_path, notice: "Welcome back, #{current_user.name}"
    end

    if request.post?
      user = User.find_by email: params[:email]
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path, notice: "You have signed in successfully."
      else
        redirect_to login_path, alert: "Invalid Credentials"
      end
    end
  end

  def create
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "You have logged out."
  end
end
