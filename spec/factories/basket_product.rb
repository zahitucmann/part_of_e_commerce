FactoryBot.define do
    factory :basket_product do
        basket { create(:basket) }
        product { create(:product) }
        quantity { Faker::Number.within(range: 1..10) }
    end
end