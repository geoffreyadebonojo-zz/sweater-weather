Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :forecasts, only: [:index]
      post '/users', to: 'users#create'
      get '/users', to: 'users#index'
      post '/sessions', to: 'sessions#create'
    end
  end
end
