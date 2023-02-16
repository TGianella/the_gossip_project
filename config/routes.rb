Rails.application.routes.draw do
  root 'gossips#index'
  get 'welcome/:first_name', to: 'welcome#user'
  get '/team', to: 'static#team'
  get '/contact', to: 'static#contact'
  resources :gossips do
    resources :comments
  end
  resources :comments, except: :create do
    resources :comments
  end
  resources :users
  resources :cities, only: [:show]
  resources :tags, only: [:show]
  resources :sessions, only: %i[new create destroy]
  delete '/logout', to: 'sessions#destroy'
  put '/gossip/:id/like', to: 'gossips#like', as: 'like'
  delete '/gossip/:id/unlike', to: 'gossips#unlike', as: 'unlike'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
