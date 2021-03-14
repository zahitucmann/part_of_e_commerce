require "rails_helper"

describe Product, type: :model do
    # Relations
    it { should have_many(:basket_products) }
    it { should have_many(:baskets) }
    it { should have_many(:ordered_products) }

    # Validations
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:stock) }


    # Instance methods
    describe '#stock_control' do
        it 'should return true if stock is greater then quantity' do
            product = create(:product)
            
            expect(product.stock_control(product.stock-1)).to be true
        end
        
        it 'should return true unless stock is less then quantity' do
            product = create(:product)
            expect(product.stock_control(product.stock+1)).to be false
        end
    end
end