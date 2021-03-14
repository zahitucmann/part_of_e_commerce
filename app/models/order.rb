class Order < ApplicationRecord
    has_many :ordered_products
    belongs_to :customer

    accepts_nested_attributes_for :ordered_products, allow_destroy: true

    after_create do
        ordered_products = OrderedProduct.where(:order_id => self.id)

        ordered_products.each do |ordered_product|
            @product = Product.find(ordered_product.product_id)
            @product.update_attribute(:stock, (@product.stock - ordered_product.quantity))
        end

        @basket = Basket.find_by(:customer_id => self.customer_id)
        BasketProduct.where(:basket_id => @basket.id).delete_all()
    end
end
