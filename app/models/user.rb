# frozen_string_literal: true

class User < ApplicationRecord
  has_many :vehicles, dependent: :destroy
  has_and_belongs_to_many :rides

  has_secure_password

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  VALID_PASSWORD = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}/
  VALID_PHONE_NUMBER = /07[0-9]{8}/
  VALID_SLACK_HANDLE = /[@][a-z0-9][a-z0-9._-]*/

  validates :email,
            presence: { message: 'Invalid email or password.' },
            uniqueness: { message: 'User already exists.' \
            ' Please Log In.' },
            format: { with: VALID_EMAIL, message: 'Invalid email or password.' }

  validates :password,
            presence: { message: 'Invalid email or password.' },
            allow_nil: true,
            confirmation: { message: 'Please confirm password' },
            format: { with: VALID_PASSWORD, message: 'Invalid email or password.' }
  validates :phone_number,
            format: { with: VALID_PHONE_NUMBER, message: 'Invalid phone number.' }
  validates :slack_handle,
            format: { with: VALID_SLACK_HANDLE, message: 'Invalid slack handle.' }
end
