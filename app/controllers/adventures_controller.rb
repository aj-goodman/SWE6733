class AdventuresController < ApplicationController
  before_action :auth_user!
  skip_before_action :verify_authenticity_token, only: :search
  def search
    adventures = Adventure.where('name LIKE ?', "%#{params[:query]}%").select(:id, :name)
    render json: adventures.to_json
  end
end
