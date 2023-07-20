# frozen_string_literal: true

require 'rails_helper'

describe 'Profile' do
  let(:user) { create :user }

  it 'creates a profile after create' do
    expect(user.profile).not_to be_nil
  end

  it 'is valid immediately upon create' do
    expect(user.profile).to be_valid
  end

  it 'cannot share a user' do
    expect(Profile.create(user:)).to_not be_valid
  end

  context 'UPDATE' do
    it 'is invalid without a location' do
      user.profile.location = nil
      expect(user.profile.valid?).to be_falsey
    end

    it 'is invalid without a date of birth' do
      user.profile.dob = nil
      expect(user.profile.valid?).to be_falsey
    end

    it 'is invalid without a seeking value' do
      user.profile.seeking = nil
      expect(user.profile.valid?).to be_falsey
    end
  end

  it 'converts location to longitude/latitude' do
    user.profile.update(location: 'New York, NY')
    expect(user.profile.lat).not_to be_nil
    expect(user.profile.long).not_to be_nil
  end
end
