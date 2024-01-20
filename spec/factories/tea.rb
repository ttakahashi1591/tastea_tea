FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety }
    type { rand(1..10) } 
    description { Faker::Lorem.sentence }
    temperature { Faker::Number.between(from: 160, to: 212) } 
    brew_time { Faker::Number.between(from: 2, to: 7) } 
  end
end