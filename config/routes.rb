Rails.application.routes.draw do
  get 'comments/new'
  get 'comments/create'
  get 'comments/edit'
  get 'comments/update'
  get 'comments/destroy'
  get 'welcome/:first_name', to: 'welcome#user'
  get '/team', to: 'static#team'
  get '/contact', to: 'static#contact'
  resources :gossips
  resources :users
  resources :cities, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
