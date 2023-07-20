# frozen_string_literal: true

class Profile < ApplicationRecord
  include Geocode
  enum seeking: %i[dates friends anything]
  has_one_attached :photo
  belongs_to :user, dependent: :destroy
  delegate :name, to: :user
  before_update :coordinate

  def age
    return 0 unless dob

    (Date.today - dob).to_i / 365
  end

  private

  def coordinate
    coordinates = Geocode.coordinate(location)
    self.lat = coordinates['lat']
    self.long = coordinates['long']
  end
end
