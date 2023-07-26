# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :auth_user!
  def index
    @current_user.profile.update(new_matches: false)
    @chats = @current_user.chats.order(updated_at: :desc)
  end

  def show
    @chat = Chat.find params[:id]
    @message = @chat.messages.new
  end

  def new_message
    chat = Chat.find params[:chat_id]
    chat.messages.create!(message_params.merge(user_id: @current_user.id))
    chat.users.find_by('users.id != ?', @current_user.id).profile.update(new_matches: true)
    redirect_to chat_path(chat), notice: 'Sent!'
  end

  def destroy
    chat = Chat.find params[:id]
    u = chat.users.find_by('users.id != ?', @current_user.id).profile
    @current_user.profile.rejects << u.id
    @current_user.profile.save
    chat.destroy
    redirect_to chats_path, alert: 'You have unmatched.'
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
