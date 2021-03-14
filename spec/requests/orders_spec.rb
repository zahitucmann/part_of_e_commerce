require 'rails_helper'

describe 'Order API', type: :request do

    it 'create order' do
        customer = create(:customer)
        basket = create(:basket, :customer => customer)
        product = create(:product, :stock => 10)
        product2 = create(:product, :stock => 15)
        basket_product = create(:basket_product, :basket => basket, :product => product, :quantity => 3)
        basket_product = create(:basket_product, :basket => basket, :product => product2, :quantity => 4)

        post '/api/v1/orders', :params => { :order => { :customer_id => customer.id } }
        
        ordered_product = JSON.parse(response.body)["ordered_products"].detect {|f| f["product_id"] == product.id }

        expect(ordered_product['product_id']).to eq(product.id)
        expect(response).to have_http_status(:success)
    end
end