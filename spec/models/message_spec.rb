# frozen_string_literal: true

require 'rails_helper'

describe 'Message' do
  let(:chat) { create :chat }
  let(:user) { create :user }

  it 'is invalid without an associated chat' do
    m = Message.new(body: "Hello world!")
    expect(m).not_to be_valid
  end
  it 'is invalid without an associated user' do
    m = chat.messages.new(body: "Hello world!")
    expect(m).not_to be_valid
  end

  it 'is valid with an associated chat AND user' do
    m = chat.messages.new(body: 'Hello world!', user_id: user.id)
    expect(m).to be_valid
  end

  it 'associates the user with the messages chat' do
    chat.messages.create(body: 'Hello world!', user_id: user.id)
    expect(chat.users).to include user
    expect(user.chats).to include chat
  end
end
