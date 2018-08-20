# frozen_string_literal: true

class User < ApplicationRecord
  has_many :vehicles
  has_many :rides, through: :vehicles

  has_secure_password

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  VALID_PASSWORD = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}/

  validates :email,
            presence: { message: 'Invalid email or password.' },
            uniqueness: { message: 'User already exists.' \
            ' Please Log In.' },
            format: { with: VALID_EMAIL, message: 'Invalid email or password.' }

  validates :password,
            presence: { message: 'Invalid email or password.' },
            confirmation: { message: 'Please confirm password' },
            format: { with: VALID_PASSWORD, message: 'Invalid email or password.' }
end
