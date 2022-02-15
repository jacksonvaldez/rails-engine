Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do

      # Non-RESTful routes
      get '/merchants/find', to: 'merchants/search#show'
      get '/items/find_all', to: 'items/search#index'

      get '/merchants/most_items', to: 'merchants/most_items#index' 

      # RESTful routes
      resources :merchants, only: [:index, :show]
      get '/merchants/:merchant_id/items', to: 'merchants/items#index'

      resources :items, only: [:index, :show, :create, :update, :destroy]
      get '/items/:item_id/merchant', to: 'items/merchants#show'

    end
  end

  # REFACTORS:
  # app/models/invoice.rb
    # refactor without using ruby
    # make it so it doesnt go through every invoice in the database

end
