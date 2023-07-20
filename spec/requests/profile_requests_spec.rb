# frozen_string_literal: true

require 'rails_helper'

describe '/profile/edit' do
  before :each do
    @user = create :user
    params = { email: @user.email, password: @user.password }
    post login_path, params:
  end

  describe 'GET' do
    it "renders the current user's profile" do
      get profile_edit_path
      expect(response).to have_http_status :ok
      expect(response).to render_template :edit
    end
  end
end
