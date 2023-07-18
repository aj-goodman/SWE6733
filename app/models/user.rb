# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :name
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }

  has_one :profile
  after_save :create_profile

  private

  def create_profile
    Profile.create(user_id: id) unless profile.present?
  end
end
