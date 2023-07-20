# frozen_string_literal: true

class Profile < ApplicationRecord
  include Geocode
  enum seeking: %i[dates friends anything]
  has_one_attached :photo
  belongs_to :user, dependent: :destroy
  delegate :name, to: :user
  before_update :coordinate

  def age
    (Date.today - dob).to_i / 365
  end

  private

  def coordinate
    attributes.merge!(Geocode.coordinate(location))
  end
end
