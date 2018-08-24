module Exceptions
  extend ActiveSupport::Concern

  class InvalidBooking < StandardError; end
end
