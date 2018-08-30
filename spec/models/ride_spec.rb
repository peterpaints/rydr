require 'rails_helper'

RSpec.describe Ride, type: :model do
  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:users) }
    it { is_expected.to belong_to(:vehicle) }
  end

  context 'validations' do
    taken = 'That ride already exists.'

    it { is_expected.to validate_presence_of(:origin) }
    it { is_expected.to validate_presence_of(:destination) }
    it { is_expected.to validate_presence_of(:departure_time) }
    it { is_expected.to validate_presence_of(:capacity) }
    it { is_expected.to validate_presence_of(:vehicle_id) }

    it do
      vehicle = create(:vehicle)
      create(:ride, vehicle_id: vehicle.id)
      is_expected.to validate_uniqueness_of(:vehicle_id)
        .scoped_to(:departure_time).with_message(taken)
    end

    it { is_expected.to allow_value('5').for(:capacity) }
    it { is_expected.not_to allow_value('0').for(:capacity) }
  end
end
