# frozen_string_literal: true

class User < ApplicationRecord
  has_many :vehicles, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_and_belongs_to_many :rides

  has_secure_password

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  VALID_PASSWORD = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}/
  VALID_PHONE_NUMBER = /\A07[0-9]{8}\z/
  VALID_SLACK_HANDLE = /[@][a-z0-9][a-z0-9._-]*/

  validates :email,
            presence: true,
            uniqueness: { message: 'User already exists.' \
            ' Please Log In.' },
            format: { with: VALID_EMAIL }

  validates :password,
            presence: true,
            allow_nil: true,
            confirmation: true,
            format: { with: VALID_PASSWORD }

  validates :phone_number,
            format: { with: VALID_PHONE_NUMBER },
            allow_nil: true

  validates :slack_handle,
            format: { with: VALID_SLACK_HANDLE },
            allow_nil: true
end
