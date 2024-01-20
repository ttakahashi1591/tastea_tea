FactoryBot.define do
  factory :book do
    title { "MyString" }
    author { "MyString" }
    genre { "MyString" }
    summary { "MyText" }
    number_sold { 1 }
  end
end