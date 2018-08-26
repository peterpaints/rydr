FactoryBot.define do
  factory :ride do
    vehicle
    origin { Faker::GameOfThrones.city }
    destination { Faker::GameOfThrones.city }
    capacity { Faker::Number.between(1, 9) }
    departure_time { Faker::Time.forward(23, :morning) }
    vehicle_id { nil }
  end
end
