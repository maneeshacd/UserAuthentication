class User < ApplicationRecord
  attr_accessor :skip_username_validation

  has_secure_password

  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, length: { minimum: 5 }, unless: :skip_username_validation
  validates :password, length: { minimum: 8 }

  before_save :set_username

  def set_username
    self.username = email.split('@').first
  end
end
