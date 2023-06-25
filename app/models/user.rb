class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :name
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
