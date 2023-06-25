require "rails_helper"

describe "New User Registration" do
  it "renders the registration page" do
    get new_user_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include "Create an Account"
  end
end