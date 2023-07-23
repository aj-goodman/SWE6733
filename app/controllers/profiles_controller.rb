# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :auth_user!
  def edit
    @profile = @current_user.profile
    @adventures = Adventure.where(id: @profile.adventures)
  end

  def update
    adventures = params[:adventures]
    adventure_ids = []
    unless adventures.blank?
      adventures.each do |adventure|
        adventure_ids << Adventure.find_or_create_by(name: adventure).id
      end
    end
    return unless @current_user.profile.update(profile_params.merge(adventures: adventure_ids))

    redirect_to profile_edit_path, notice: 'Changes saved.'
  end

  private

  def profile_params
    params.require(:profile).permit(:bio, :location, :dob, :seeking, :photo, :gender, :looking_for)
  end
end
