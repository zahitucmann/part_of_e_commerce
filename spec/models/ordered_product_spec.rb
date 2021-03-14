require "rails_helper"

describe OrderedProduct, type: :model do
    # Relations
    it { should belong_to(:order) }
    it { should belong_to(:product) }


    # Custom validation methods
    describe '#check_product_stock' do
        
        it 'should be valid if stock is greater then quantity' do
            customer = create(:customer)
            basket = create(:basket, :customer => customer)
            product = create(:product, :stock => 10)
            create(:basket_product, :basket => basket, :product => product, :quantity => 3)
            order = create(:order, :customer => customer)
            
            
            expect(create(:ordered_product, :order => order, :product => product, :quantity => 3, :product_name => product.name, :product_price => product.price, :product_color => product.color)).to be_valid
        end
        
        it 'should return true unless stock is less then quantity' do
            customer = create(:customer)
            basket = create(:basket, :customer => customer)
            product = create(:product, :stock => 10)
            create(:basket_product, :basket => basket, :product => product, :quantity => 3)
            order = create(:order, :customer => customer)
  
            expect {create(:ordered_product, :order => order, :product => product, :quantity => 11, :product_name => product.name, :product_price => product.price, :product_color => product.color)}.to raise_error(ActiveRecord::RecordInvalid)
        end
    end
end