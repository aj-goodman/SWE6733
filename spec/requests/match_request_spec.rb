# frozen_string_literal: true

require 'rails_helper'

describe '/matches' do
  let(:user) { build :user }

  before :each do
    user.reload
    params = { email: user.email, password: user.password }
    post login_path, params:
  end

  it 'routes successfully' do
    get matches_path
    expect(response).to have_http_status :ok
  end

  it 'renders the matches index' do
    get matches_path
    expect(response).to render_template 'matches/index'
  end

  it 'renders the matches index' do
    get matches_path
    expect(response).to render_template 'matches/index'
  end

  it 'renders a potential match' do
    user.profile.update(seeking: 'Woman', gender: 'Man', looking_for: 'anything')
    u = build :user
    u.profile.update(seeking: 'Man', gender: 'Woman', looking_for: 'anything')
    get matches_path
    expect(response.body).to include u.name
  end

  describe '/matches/accept' do
    let(:user) { build :user }
    let(:user2) { build :user }

    before :each do
      user.reload
      params = { email: user.email, password: user.password }
      post login_path, params:
    end

    it 'adds the profile ID to the accepts array' do
      post '/matches/accept', params: { id: user2.id }
      expect(user.accepts).to include user2.id
    end
  end

  describe '/matches/reject' do
    let(:user) { build :user }
    let(:user2) { build :user }

    before :each do
      user.reload
      user2.reload
      params = { email: user.email, password: user.password }
      post login_path, params:
    end

    it 'adds the profile ID to the accepts array' do
      post '/matches/reject', params: { id: user2.id }
      expect(user.rejects).to include user2.id
    end
  end
end
