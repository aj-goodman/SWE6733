# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :auth_user!
  def edit
    @profile = @current_user.profile
  end

  def update
    if @current_user.profile.update(profile_params)
      redirect_to profile_edit_path, notice: "Changes saved."
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:location, :dob, :seeking, :photo)
  end
end
