class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true, on: :create
  validates_presence_of :password, require: true

  has_secure_password

  before_create :set_api_key

  def set_api_key
    self.api_key = generate_api_key
  end

  def generate_api_key
    SecureRandom.hex(14)
  end
end
