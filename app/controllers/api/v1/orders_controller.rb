module Api
    module V1
        class OrdersController < ApplicationController
            def create
                @basket = Basket.find_by(:customer_id => order_params[:customer_id])

                if @basket && @basket.basket_products.count > 0
                    ordered_products = []
 
                    @basket.basket_products.each do |basket_product|
                        ordered_products.push({"product_id": basket_product.product.id, "product_name": basket_product.product.name, "product_color": basket_product.product.color, "product_price": basket_product.product.price, "quantity": basket_product.quantity})
                    end
              
                    new_order_params = order_params
                    new_order_params["ordered_products_attributes"] = ordered_products
                
                    @order = Order.new(new_order_params)
                 
                    if @order.save
                        render json: {status: 'SUCCESS', message: 'Order created', order_id: @order.id, ordered_products: OrderedProduct.where(:order_id => @order.id)}, status: :ok
                    else
                        render json: {status: 'ERROR', message: 'Order did not created', errors: @order.errors}, status: :unprocessable_entity
                    end
                else
                    render json: {status: 'ERROR', message: 'Order did not created', errors: "Customer's basket can not be empty"}, status: :unprocessable_entity
                end
                
            end

            private

            def order_params
                params.require(:order).permit(:customer_id, :ordered_products_attributes => [:product_id, :product_name, :product_price, :product_color, :quantity])
            end
        end
    end
end
