require 'rails_helper'

describe 'Customer API', type: :request do
    it 'returns all customers' do
        create_list(:customer, 2)

        get '/api/v1/customers'

        expect(JSON.parse(response.body)["data"].size).to eq(2)
        expect(response).to have_http_status(:success)
    end

    it 'create customer' do
        post '/api/v1/customers', :params => { :first_name => "exampleFirstName", :last_name => 'exampleLastName', :gender => 'Male', :age => 22, :email => 'example@test.com', :phone => '123456' }

        expect(response).to have_http_status(:success)
    end

    it 'update customer' do
        customer = create(:customer)

        put '/api/v1/customers/' + customer.id.to_s, :params => { :first_name => "exampleFirstName", :last_name => 'exampleLastName', :gender => 'Female', :age => 25, :email => 'example@test.com', :phone => '22222222' }

        returned_customer_phone = JSON.parse(response.body)["data"]['phone']

        expect(returned_customer_phone).to eq('22222222')
        expect(response).to have_http_status(:success)
    end

    it 'show customer' do
        customer = create(:customer)
        
        get '/api/v1/customers/' + customer.id.to_s

        returned_customer_email = JSON.parse(response.body)["data"]['email']

        expect(returned_customer_email).to eq(customer.email)
        expect(response).to have_http_status(:success)
    end

    it 'customer get last order' do
        customer = create(:customer)
        basket = create(:basket, :customer => customer)
        product = create(:product, :stock => 10)
        basket_product = create(:basket_product, :basket => basket, :product => product, :quantity => 3)
        order = create(:order, :customer => customer)
        
        create(:ordered_product, :order => order, :product => product, :quantity => 5, :product_name => product.name, :product_price => product.price, :product_color => product.color)
        
        get '/api/v1/customers/' + customer.id.to_s + '/get_last_order'

        returned_time = JSON.parse(response.body)["created_at"].to_datetime

        expect(returned_time.strftime("%d/%m/%Y %H:%M")).to eq(Order.where(:customer_id => customer.id).order(created_at: :desc).first.created_at.strftime("%d/%m/%Y %H:%M"))
        expect(response).to have_http_status(:success)
    end
end