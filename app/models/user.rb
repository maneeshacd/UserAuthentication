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

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save(validate: false)
    UserMailer.password_reset(self).deliver
  end
end
