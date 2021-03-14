class BasketProduct < ApplicationRecord
    belongs_to :basket
    belongs_to :product

    validate :check_product_stock

    def check_product_stock
        return if self.product.blank?
        
        if !self.product.stock_control(self.quantity)
            errors.add(:quantity, 'can not greater than stock')
        end
    end
end
