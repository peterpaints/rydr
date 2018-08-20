# frozen_string_literal: true

class Ride < ApplicationRecord
  has_many :users
  belongs_to :vehicle
end
