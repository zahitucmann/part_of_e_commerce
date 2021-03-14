FactoryBot.define do
    factory :product do
        name { Faker::Name.last_name }
        stock { Faker::Number.within(range: 0..1000) }
        color { Faker::Color.color_name }
        price { Faker::Number.within(range:1..10000) }
    end
end