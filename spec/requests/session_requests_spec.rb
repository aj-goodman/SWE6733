# frozen_string_literal: true

require 'rails_helper'

describe '/sessions/new' do
  describe 'GET' do
    before :each do
      get login_path
    end

    it 'renders the login page' do
      expect(response).to have_http_status :ok
      expect(response.body).to include 'Log in'
    end
  end

  describe 'POST' do
    context 'successful authentication' do
      before :each do
        @user = create :user
        params = { email: @user.email, password: @user.password }
        post login_path, params:
      end

      it 'sets the session user id' do
        expect(session[:user_id]).to eq @user.id
      end

      it 'redirects to root_path' do
        expect(response).to redirect_to(root_path)
      end

      it 'renders the matches index' do
        follow_redirect!
        expect(response).to render_template 'matches/index'
      end
    end

    context 'failed authentication' do
      before :each do
        params = { email: 'email@email', password: 'wrongPassword' }
        post login_path, params:
      end

      it 'does not set the session user id' do
        expect(session[:user_id]).to eq nil
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to login_path
      end
    end
  end
end

describe '/logout' do
  describe 'DELETE' do
    before :each do
      @user = create :user
      params = { email: @user.email, password: @user.password }
      post(login_path, params:)
      delete logout_path
    end

    it 'removes the session user id' do
      expect(session[:user_id]).to eq nil
    end

    it 'redirects to the login page' do
      expect(response).to redirect_to(login_path)
    end
  end
end
