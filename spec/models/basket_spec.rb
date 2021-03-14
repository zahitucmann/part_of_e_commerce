require "rails_helper"

describe Basket, type: :model do
    # Relations
    it { should have_many(:basket_products) }
    it { should have_many(:products) }
    it { should belong_to(:customer) }
end