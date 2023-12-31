# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :name
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }

  has_one :profile, dependent: :destroy
  delegate :matches, :rejects, :accepts, :new_matches, to: :profile
  after_save :create_profile

  has_many :messages
  has_many :chats, -> { distinct }, through: :messages

  private

  def create_profile
    Profile.find_or_create_by!(user_id: id)
  end
end
