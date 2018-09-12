# frozen_string_literal: true

class Vehicle < ApplicationRecord
  has_many :rides, dependent: :destroy
  belongs_to :user

  VALID_PLATE = /[A-Z]{3} [0-9]{3}[A-Z]{1}/
  VALID_CAPACITY = /[1-9]/

  validates :make, :model, :license_plate, :capacity, :color,
            presence: true

  validates :license_plate,
            uniqueness: { message: 'That vehicle already exists.' },
            format: { with: VALID_PLATE }

  validates :capacity,
            format: { with: VALID_CAPACITY }
end
