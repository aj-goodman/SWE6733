# frozen_string_literal: true

class Profile < ApplicationRecord
  include Geocode
  enum looking_for: %i[dates friends anything]
  has_one_attached :photo
  belongs_to :user, dependent: :destroy
  delegate :name, to: :user
  before_update :coordinate

  validates_presence_of %i[location dob seeking], on: :update
  validates_uniqueness_of :user_id

  GENDERS = %w[Man Woman].freeze
  SEEKING = GENDERS + ["Both"]

  validates_inclusion_of :gender, in: GENDERS, on: :update
  validates_inclusion_of :seeking, in: SEEKING, on: :update


  def age
    return 0 unless dob

    (Date.today - dob).to_i / 365
  end

  def date_icon
    { "dates" => "heart", "friends" => "people-group", "anything" => "people-pulling"}[looking_for]
  end

  def gender_icon
    { "Man" => "mars", "Woman" => "venus" }[gender]
  end

  def matches
    profiles = Profile.where(seeking: [gender, "both"]).where.not(id: rejects)
    profiles = profiles.where(gender: seeking) unless seeking == "both"
    profiles = Hash[profiles.map {|x| [x, 100]}]
    profiles.keys.each do |profile|
      profiles[profile] += 100 * (adventures && profile.adventures).length
      if profile.looking_for == looking_for
        profiles[profile] += 300
      else
        profiles[profile] += 150 if profile.looking_for == "anything"
      end
      distance = Geocode.distance(from: self, to: profile)
      profiles[profile] = profiles[profile] / distance
      profiles[profile] = profiles[profile] / (age - profile.age).abs
    end
    profiles.sort_by { |_k,v | v }.reverse.map(&:first)
  end

  private

  def coordinate
    coordinates = Geocode.coordinate(location)
    self.lat = coordinates['lat']
    self.long = coordinates['long']
  end
end
