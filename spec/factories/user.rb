FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    # password { Faker::Internet.password(7, 9, true, false) }
    password { 'Testpassword1' }
  end
end
