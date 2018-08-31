# frozen_string_literal: true

module Exceptions
  extend ActiveSupport::Concern

  class OwnerBooking < StandardError; end
  class RideFull < StandardError; end
  class VehicleOverload < StandardError; end
  class InvalidTime < StandardError; end
  class RiderLacksSeating < StandardError; end
end
