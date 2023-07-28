# frozen_string_literal: true

class Profile < ApplicationRecord
  include Geocode
  enum looking_for: %i[dates friends anything]
  has_one_attached :photo
  belongs_to :user, dependent: :destroy
  delegate :name, to: :user
  before_update :coordinate

  validates_presence_of %i[location dob seeking], on: :validate
  validates_uniqueness_of :user_id

  GENDERS = %w[Man Woman].freeze
  SEEKING = GENDERS + ['Both']

  validates_inclusion_of :gender, in: GENDERS, on: :validate
  validates_inclusion_of :seeking, in: SEEKING, on: :validate

  def age
    return 0 unless dob

    (Date.today - dob).to_i / 365
  end

  def date_icon
    { 'dates' => 'heart', 'friends' => 'people-group', 'anything' => 'people-pulling' }[looking_for]
  end

  def gender_icon
    { 'Man' => 'mars', 'Woman' => 'venus' }[gender]
  end

  def matches
    profiles = Profile.where(seeking: [gender, 'Both']).where.not(id: rejects.concat(accepts))
    profiles = profiles.where(gender: seeking) unless seeking == 'Both'
    profiles = Hash[profiles.map { |x| [x, 100] }]
    profiles.each_key do |profile|
      profiles[profile] += 100 * (adventures && profile.adventures).length
      if profile.looking_for == looking_for
        profiles[profile] += 300
      elsif profile.looking_for == 'anything'
        profiles[profile] += 150
      end
      distance = Geocode.distance(from: self, to: profile)
      profiles[profile] = profiles[profile] / distance
      age_diff = (age - profile.age).abs
      profiles[profile] = profiles[profile] / (age_diff.zero? ? 1 : age_diff)
    end
    profiles.sort_by { |_k, v| v }.reverse.map(&:first)
  end

  private

  def coordinate
    return unless location_changed? && location.present?

    coordinates = Geocode.coordinate(location)
    self.lat = coordinates['lat']
    self.long = coordinates['long']
  end
end
