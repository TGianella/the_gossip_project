Rails.application.routes.draw do
  root 'gossips#index'
  get 'welcome/:first_name', to: 'welcome#user'
  get '/team', to: 'static#team'
  get '/contact', to: 'static#contact'
  resources :gossips
  resources :users
  resources :cities, only: [:show]
  resources :comments, except: %i[index show new create]
  get 'gossips/:gossip_id/comment/new', to: 'comments#new', as: 'new_comment'
  post 'gossips/:id/comments', to: 'comments#create', as: 'comments'
  resources :tags, only: [:show]
  resources :sessions, only: %i[new create destroy]
  delete '/logout', to: 'sessions#destroy'
  put '/gossip/:id/like', to: 'gossips#like', as: 'like'
  delete '/gossip/:id/unlike', to: 'gossips#unlike', as: 'unlike'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
