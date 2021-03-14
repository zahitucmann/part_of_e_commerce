class Customer < ApplicationRecord
    has_many :baskets
    has_many :orders
    
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :phone, presence: true
end
