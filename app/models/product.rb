class Product < ApplicationRecord
    has_many :basket_products
    has_many :baskets, through: :basket_products
    has_many :ordered_products

    validates :name, presence: true
    validates :price, presence: true
    validates :stock, presence: true

    def stock_control(quantity)
        self.stock >= quantity
    end
end
