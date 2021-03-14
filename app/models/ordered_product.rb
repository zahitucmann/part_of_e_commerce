class OrderedProduct < ApplicationRecord
    belongs_to :order
    belongs_to :product

    #Validates
    validate :check_product_stock

    def check_product_stock
        return if self.product.blank?

        errors.add(:quantity, 'can not greater than stock.') if !self.product.stock_control(self.quantity)
    end
end
