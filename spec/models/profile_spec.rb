# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  let(:user) { create :user }

  it 'creates a profile after create' do
    expect(user.profile).not_to be_nil
  end

  it 'converts location to longitude/latitude' do
    user.profile.update(location: 'New York, NY')
    expect(user.profile.lat).not_to be_nil
    expect(user.profile.long).not_to be_nil
  end
end
