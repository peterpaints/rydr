# frozen_string_literal: true

module FilterSearch
  extend ActiveSupport::Concern

  def filter_rides(params)
    @rides = @rides.reverse if params[:filter] == 'asc'
    @rides = @rides.filter_by_user(current_user) if params[:filter] == 'mine'

    search_params(params).each do |key, value|
      @rides = @rides.public_send(key, value) if value.present?
    end

    respond_to { |format| format.js }
  end
end
