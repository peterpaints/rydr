require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:vehicles) }
    it { is_expected.to have_and_belong_to_many(:rides) }
  end

  context 'validations' do
    taken = 'User already exists. Please Log In.'

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).with_message(taken) }
    it { is_expected.to allow_value('user@example.com').for(:email) }
    it { is_expected.not_to allow_value('user.com').for(:email) }

    it { is_expected.to have_secure_password }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to allow_value('TestPassword1').for(:password) }
    it { is_expected.not_to allow_value('password').for(:password) }

    it { is_expected.to allow_value('0712345678').for(:phone_number) }
    it { is_expected.not_to allow_value('1234567890').for(:phone_number) }

    it { is_expected.to allow_value('@johndoe').for(:slack_handle) }
    it { is_expected.not_to allow_value('johndoe').for(:slack_handle) }
  end
end
