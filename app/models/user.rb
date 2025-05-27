class User < ApplicationRecord
  has_secure_password

  validates :email_address, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }

  has_many :sessions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :change_logs, dependent: :nullify

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
