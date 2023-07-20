# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  before :each do
    @user = build :user
  end

  it 'is valid with an email address, password, and name' do
    expect(@user.valid?).to eq true
  end

  it 'is invalid without an email address' do
    @user.email = nil
    expect(@user.valid?).to eq false
  end

  it 'is invalid with an unformatted email address' do
    @user.email = 'email'
    expect(@user.valid?).to eq false
  end

  it 'is invalid without a password' do
    @user.password_digest = nil
    expect(@user.valid?).to eq false
  end

  it 'is invalid with a password length < 6' do
    @user.password = '123'
    expect(@user.valid?).to eq false
  end

  it 'is invalid without a name' do
    @user.name = nil
    expect(@user.valid?).to eq false
  end

  context 'after create' do
    it 'creates an associated profile' do
      @user = create :user
      expect(@user.profile).not_to eq nil
    end
  end
end
