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
    if profile_params.except('photo').values.compact!.blank? && params[:profile][:photo].present?
      @current_user.profile.photo.attach(params[:profile][:photo])
      @current_user.profile.save!(validate: false, context: :attachment)
    else
      p = @current_user.profile
      p.assign_attributes(profile_params.merge(adventures: adventure_ids))
      p.save(context: :validate)
    end

    redirect_to profile_edit_path, notice: 'Changes saved.'
  end

  private

  def profile_params
    params.require(:profile).permit(:bio, :location, :dob, :seeking, :photo, :gender, :looking_for)
  end
end
