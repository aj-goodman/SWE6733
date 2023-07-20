# frozen_string_literal: true

require 'rails_helper'

describe '/profile/edit' do
  let(:user) { build :user }

  before :each do
    user.reload
    params = { email: user.email, password: user.password }
    post login_path, params:
  end

  describe 'GET' do
    it "renders the current user's profile" do
      get profile_edit_path
      expect(response).to have_http_status :ok
      expect(response).to render_template :edit
    end
  end

  describe 'UPDATE' do
    before :each do
      @bio = { profile: { bio: 'bio', location: 'New York, NY', dob: Date.today - 25.years, seeking: 'friends' } }
    end

    it 'updates the profile attributes' do
      patch profile_path, params: @bio
      @bio[:profile].each do |k, v|
        expect(user.profile.send(k)).to eq v
      end
    end

    it 'redirects to the profile edit page' do
      patch profile_path, params: @bio
      expect(response).to have_http_status :found
      expect(response).to redirect_to profile_edit_path
    end

    describe 'Adventures' do
      context 'Existing Adventure' do
        let(:adventure) { create :adventure }

        before :each do
          @bio.merge!({ adventures: [adventure.name] })
        end

        it 'adds the adventure to the Profile' do
          patch profile_path, params: @bio
          expect(user.profile.adventures).to include(adventure.id)
        end
      end

      context 'New Adventure' do
        before :each do
          @bio.merge!({ adventures: ['New Adventure'] })
        end

        it 'adds the adventure to the Profile' do
          patch profile_path, params: @bio
          adventure = Adventure.find_by(name: 'New Adventure')
          expect(adventure).to be_present
          expect(user.profile.adventures).to include(adventure.id)
        end
      end
    end
  end
end
