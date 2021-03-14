module Api
    module V1
        class CustomersController < ApplicationController
            def index
                @customers = Customer.all

                render json: {status: 'SUCCESS', message: 'Loaded all customers', data: @customers}, status: :ok
            end

            def show
                @customer = Customer.find(params[:id])

                render json: {status: 'SUCCESS', message: 'Loaded customer', data: @customer}, status: :ok
            end


            def create
                @customer = Customer.new(customer_params)

                if @customer.save
                    render json: {status: 'SUCCESS', message: 'Saved customer', data: @customer}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Customer not saved', data: @customer.errors}, status: :unprocessable_entity
                end
            end

            def update
                @customer = Customer.find(params[:id])

                if @customer.update_attributes(customer_params)
                    render json: {status: 'SUCCESS', message: 'Updated customer', data: @customer}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Customer not updated', data: @customer.errors}, status: :unprocessable_entity
                end
            end

            def get_last_order
                @order = Order.where(:customer_id => params[:id]).order(created_at: :desc).first

                render json: {status: 'SUCCESS', message: 'Last Order Details', created_at: @order.created_at, products: OrderedProduct.where(:order_id => @order.id)}, status: :ok
            end

            private

            def customer_params
                params.permit(:first_name, :last_name, :email, :age, :gender, :phone)
            end
        end
    end
end
