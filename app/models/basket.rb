class Basket < ApplicationRecord
    has_many :basket_products
    has_many :products, through: :basket_products
    belongs_to :customer
end
