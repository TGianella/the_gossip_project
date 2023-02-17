Rails.application.routes.draw do
  root 'gossips#index'
  get 'welcome/:first_name', to: 'welcome#user'
  get '/team', to: 'static#team'
  get '/contact', to: 'static#contact'
  resources :gossips do
    resources :comments
    resources :likes, only: %i[new create destroy]
  end
  resources :comments, except: :create do
    resources :comments
    resources :likes, only: %i[new create destroy]
  end
  resources :users do
    resources :likes, only: %i[new create destroy]
  end
  resources :cities, only: [:show] do
    resources :likes, only: %i[new create destroy]
  end
  resources :tags, only: [:show] do
    resources :likes, only: %i[new create destroy]
  end
  resources :sessions, only: %i[new create destroy]
  delete '/logout', to: 'sessions#destroy'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
