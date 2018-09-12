FactoryBot.define do
  factory :vehicle do
    make { Faker::Vehicle.make }
    model { Faker::Vehicle.model }
    license_plate { 'KCR 232C' }
    capacity { 9 }
    color { Faker::Vehicle.color }
    user
  end
end
