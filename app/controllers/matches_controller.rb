# frozen_string_literal: true

class MatchesController < ApplicationController
  before_action :auth_user!
  skip_before_action :verify_authenticity_token, only: :decide

  def index
    @profile = @current_user.matches.sample
    @adventures = Adventure.where id: @profile.adventures
  end

  def decide
    if params[:accept]

    else
      profile = @current_user.profile
      profile.rejects << params[:id].to_i
      profile.save
      profile = @current_user.matches.sample
      adventures = Adventure.where id: profile.adventures
      render json: { profile: render_to_string(partial: "profiles/preview", locals: { profile: profile, adventures: adventures, hide: false}) }
    end
  end
end
