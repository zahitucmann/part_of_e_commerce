FactoryBot.define do

    factory :ordered_product do
        order { create(:order) }
        product { create(:product) }
        product_name { product.name }
        product_price { product.price }
        product_color { product.color }
        quantity { Faker::Number.within(range: 1..10) }
    end
end