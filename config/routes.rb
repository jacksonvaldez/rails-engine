Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do

      # Non-RESTful routes
      get '/merchants/find_all', to: 'search#index'
      get '/items/find', to: 'search#show'

      # RESTful routes
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resource :merchant, only: [:show]
      end

    end
  end

end
