# frozen_string_literal: true

class Ride < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :vehicle
end
