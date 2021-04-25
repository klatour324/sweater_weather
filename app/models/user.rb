class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates_presence_of :password, require: true

  has_secure_password

  # before_create do |user|
  #   user.api_key = user.generate_api_key
  # end

  before_create :set_api_key
  def set_spi_key
    self.api_key = generate_api_key
  end

  def generate_api_key
    # loop do
      SecureRandom.base64.tr('+/=', 'Qrt')
      # break token unless User.exists?(api_key: token)
    # end
  end
end
