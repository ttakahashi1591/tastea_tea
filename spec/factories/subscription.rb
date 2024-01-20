FactoryBot.define do
  factory :subscription do
    name { Faker::Lorem.word }
    price { Faker::Commerce.price(range: 10.0..100.0) }
    frequency { %w[monthly yearly].sample }
    status { Faker::Boolean.boolean }
  end
end