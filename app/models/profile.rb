# frozen_string_literal: true

class Profile < ApplicationRecord
  include Geocode
  enum seeking: %i[dates friends anything]
  has_one_attached :photo
  belongs_to :user
  delegate :name, to: :user
  before_update :coordinate

  private

  def coordinate
    self.attributes = attributes.merge!(Geocode.coordinate(location))
  end
end
