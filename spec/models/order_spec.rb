require "rails_helper"

describe Order, type: :model do
    # Relations
    it { should have_many(:ordered_products) }
    it { should belong_to(:customer) }
end