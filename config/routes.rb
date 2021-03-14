Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :customers do
        member do
          get "get_last_order"
        end
      end

      resources :products do 
        member do
          post "add_to_basket"
        end
      end

      resources :orders
      
    end
  end
end
