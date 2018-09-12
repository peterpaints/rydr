FactoryBot.define do
  factory :notification do
    user
    message { Faker::SiliconValley.quote }
  end
end
