# frozen_string_literal: true

module Exceptions
  extend ActiveSupport::Concern

  class InvalidBooking < StandardError; end
  class RideFull < StandardError; end
end
