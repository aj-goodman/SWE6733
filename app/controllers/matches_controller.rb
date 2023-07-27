# frozen_string_literal: true

class MatchesController < ApplicationController
  before_action :auth_user!
  skip_before_action :verify_authenticity_token, only: %i[reject accept]

  def index
    redirect_to profile_edit_path and return unless @current_user.profile.valid?(:validate)

    @profile = @current_user.matches.sample
    @adventures = Adventure.where id: @profile.adventures if @profile
  end

  def reject
    profile = @current_user.profile
    profile.rejects << params[:id].to_i
    profile.save
    profile = @current_user.matches.sample
    adventures = Adventure.where id: profile.adventures
    render json: { profile: render_to_string(partial: 'profiles/preview',
                                             locals: { profile:,
                                                       adventures:, hide: false }) }
  end

  def accept
    profile = @current_user.profile
    profile.accepts << params[:id].to_i
    match = Profile.find(params[:id]).user
    matched = false
    if match.accepts.include?(@current_user.profile.id)
      chat = Chat.create!
      chat.messages.create(user_id: @current_user.id, body: 'We matched!')
      chat.messages.create(user_id: match.id, body: 'We matched!')
      flash[:success] = 'You got a match!'
      profile.new_matches = match.profile.new_matches = matched = true
    end
    profile.save
    profile = @current_user.matches.sample
    adventures = Adventure.where id: profile.adventures if profile
    payload = { matched: matched }
    if profile
      payload[:profile] = render_to_string(partial: 'profiles/preview',
                                             locals: { profile:,
                                                       adventures:, hide: false })
    end
    render json: payload
  end
end
