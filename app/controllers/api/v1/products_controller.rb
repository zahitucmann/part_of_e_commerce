module Api
    module V1
        class ProductsController < ApplicationController
            def index
                @products = Product.all

                render json: {status: 'SUCCESS', message: 'Loaded all products', data: @products}, status: :ok
            end

            def show
                @product = Product.find(params[:id])

                render json: {status: 'SUCCESS', message: 'Loaded product', data: @product}, status: :ok
            end


            def create
                @product = Product.new(product_params)

                if @product.save
                    render json: {status: 'SUCCESS', message: 'Saved product', data: @product}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Product not saved', errors: @product.errors}, status: :unprocessable_entity
                end
            end

            def update
                @product = Product.find(params[:id])

                if @product.update_attributes(product_params)
                    render json: {status: 'SUCCESS', message: 'Updated product', data: @product}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Product not updated', errors: @product.errors}, status: :unprocessable_entity
                end
            end

            def add_to_basket
                @basket = Basket.find_by(:customer_id => params[:customer_id])
                if @basket
                    @basket_product = @basket.basket_products.new(product_id: params[:id], quantity: params[:quantity])
                else
                    @basket = Basket.create(customer_id: params[:customer_id])
                    @basket_product = @basket.basket_products.new(product_id: params[:id], quantity: params[:quantity])
                end

                if @basket_product.save
                    render json: {status: 'SUCCESS', message: 'Product added to basket', data: @basket.basket_products}, status: :ok
                else 
                    render json: {status: 'ERROR', message: 'Product did not add to basket', errors: @basket_product.errors}, status: :unprocessable_entity
                end
            end

            private

            def product_params
                params.permit(:name, :price, :stock, :color)
            end
        end
    end
end
