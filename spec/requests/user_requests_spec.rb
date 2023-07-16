# frozen_string_literal: true

require 'rails_helper'

describe '/users/new' do
  describe 'GET' do
    it 'renders the registration page' do
      get new_user_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include 'Create an Account'
    end
  end

  describe 'POST' do
    context 'valid user' do
      before :each do
        password = SecureRandom.hex(6)
        @params = { user: { name: 'Name', email: 'email@email', password:, password_confirmation: password } }
        post new_user_path, params: @params
      end

      it 'creates a new user' do
        expect(User.last.authenticate(@params[:user][:password])).to eq User.last
        expect(User.last.name).to eq @params[:user][:name]
        expect(User.last.email).to eq @params[:user][:email]
      end

      it 'sets the session user_id' do
        expect(session[:user_id]).to eq User.last.id
      end

      it 'redirects to root_path' do
        expect(response).to redirect_to(root_path)
      end

      it 'renders the matches index' do
        follow_redirect!
        expect(response).to render_template 'matches/index'
      end
    end

    context 'missing name' do
      before :each do
        password = SecureRandom.hex(6)
        @params = { user: { name: '', email: 'email@email', password:, password_confirmation: password } }
      end
      it 'renders the register page' do
        post new_user_path, params: @params
        expect(response).to have_http_status :bad_request
        expect(response).to render_template :new
      end

      it 'does not create the user' do
        expect(User.count).to eq 0
      end
    end

    context 'malformed email' do
      before :each do
        password = SecureRandom.hex(6)
        @params = { user: { name: 'Name', email: 'email', password:, password_confirmation: password } }
      end

      it 'renders the register page' do
        post new_user_path, params: @params
        expect(response).to have_http_status :bad_request
        expect(response).to render_template :new
      end

      it 'does not create the user' do
        expect(User.count).to eq 0
      end
    end

    context 'password length < 6' do
      before :each do
        password = SecureRandom.hex(2)
        @params = { user: { name: 'Name', email: 'email@email', password:, password_confirmation: password } }
      end

      it 'renders the register page' do
        post new_user_path, params: @params
        expect(response).to have_http_status :bad_request
        expect(response).to render_template :new
      end

      it 'does not create the user' do
        expect(User.count).to eq 0
      end
    end

    context 'mismatching passwords' do
      before :each do
        password = SecureRandom.hex(6)
        @params = { user: { name: 'Name', email: 'email@email', password:,
                            password_confirmation: "#{password}1.md" } }
      end

      it 'renders the register page' do
        post new_user_path, params: @params
        expect(response).to have_http_status :bad_request
        expect(response).to render_template :new
      end

      it 'does not create the user' do
        expect(User.count).to eq 0
      end
    end
  end
end
