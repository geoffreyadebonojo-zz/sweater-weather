Rails.application.routes.draw do

  get 'favorites/create'
  namespace :api do
    namespace :v1 do
      resources :forecasts, only: [:index]
      post '/users', to: 'users#create'
      get '/users', to: 'users#index'
      post '/sessions', to: 'sessions#create'
      post '/favorites', to: 'favorites#create'
    end
  end
end
