Rails.application.routes.draw do
  get '/', to: 'api/v1/forecasts#index'
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecasts#index'
      post '/users', to: 'users#create'
      get '/users', to: 'users#index'
      post '/sessions', to: 'sessions#create'
      post '/favorites', to: 'favorites#create'
      get '/favorites', to: 'favorites#index'
      delete '/favorites', to: 'favorites#destroy'
    end
  end
end
