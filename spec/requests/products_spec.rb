require 'rails_helper'

describe 'Product API', type: :request do
    it 'returns all products' do
        create_list(:product, 2)

        get '/api/v1/products'

        expect(JSON.parse(response.body)["data"].size).to eq(2)
        expect(response).to have_http_status(:success)
    end

    it 'create product' do
        post '/api/v1/products', :params => { :name => "exampleName", :price => 450, :stock => 15, :color => 'green' }

        expect(response).to have_http_status(:success)
    end

    it 'update product' do
        product = create(:product)

        put '/api/v1/products/' + product.id.to_s, :params => { :name => "exampleName", :price => 500, :stock => 15, :color => 'grey' }

        returned_product_price = JSON.parse(response.body)["data"]['price']

        expect(returned_product_price.to_i).to eq(500)
        expect(response).to have_http_status(:success)
    end

    it 'show product' do
        product = create(:product)
        
        get '/api/v1/products/' + product.id.to_s

        returned_product_name = JSON.parse(response.body)["data"]['name']

        expect(returned_product_name).to eq(product.name)
        expect(response).to have_http_status(:success)
    end

    it 'add to basket' do 
        product = create(:product, :stock => 10)
        
        post '/api/v1/products/' + product.id.to_s + '/add_to_basket', :params => { :quantity => 3 }

        added_product = JSON.parse(response.body)["data"].detect {|f| f["product_id"] == product.id }

        expect(added_product['product_id']).to eq(product.id)
        expect(response).to have_http_status(:success)
    end

    
end