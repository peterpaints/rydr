require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:rides) }
    it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    taken = 'That vehicle already exists.'

    it { is_expected.to validate_presence_of(:make) }
    it { is_expected.to validate_presence_of(:model) }
    it { is_expected.to validate_presence_of(:license_plate) }
    it { is_expected.to validate_presence_of(:capacity) }
    it { is_expected.to validate_presence_of(:color) }

    it { is_expected.to validate_uniqueness_of(:license_plate).with_message(taken) }
    it { is_expected.to allow_value('KCR 232C').for(:license_plate) }
    it { is_expected.not_to allow_value('KCR 232').for(:license_plate) }

    it { is_expected.to allow_value('5').for(:capacity) }
    it { is_expected.not_to allow_value('0').for(:capacity) }
  end
end
