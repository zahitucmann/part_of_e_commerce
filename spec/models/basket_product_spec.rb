require "rails_helper"

describe BasketProduct, type: :model do
    # Relations
    it { should belong_to(:basket) }
    it { should belong_to(:product) }


    # Custom validation methods
    describe '#check_product_stock' do
        it 'should be valid if stock is greater then quantity' do
            basket = create(:basket)
            product = create(:product, :stock => 10)
            expect(create(:basket_product, :basket => basket, :product => product, :quantity => 3)).to be_valid
        end
        
        it 'should return true unless stock is less then quantity' do
            basket = create(:basket) 
            product = create(:product, :stock => 3) 
            expect {create(:basket_product, :basket => basket, :product => product, :quantity => 10)}.to raise_error(ActiveRecord::RecordInvalid)
        end
    end
end