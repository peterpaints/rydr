# frozen_string_literal: true

class Vehicle < ApplicationRecord
  has_many :rides
  belongs_to :user
end
