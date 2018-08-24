# frozen_string_literal: true

class Vehicle < ApplicationRecord
  has_many :rides
  belongs_to :user

  VALID_PLATE = /[A-Z]{3} [0-9]{3}[A-Z]{1}/
  VALID_CAPACITY = /[0-9]/

  validates :make, :model, :license_plate, :capacity, :color,
            presence: { message: 'Please enter every attribute.' }
  validates :license_plate,
            uniqueness: { message: 'That vehicle already exists.' },
            format: { with: VALID_PLATE, message: 'Invalid plate format.' }
  validates :capacity,
            format: { with: VALID_CAPACITY, message: 'Invalid capacity format.' }
end
