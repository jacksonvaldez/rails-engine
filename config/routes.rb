Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do

      # Non-RESTful routes
      get '/merchants/find_all', to: 'merchants/search#index'
      get '/items/find', to: 'items/search#show'

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
