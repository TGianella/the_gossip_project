Rails.application.routes.draw do
  get 'user/:id/show', to: 'user#show', as: 'user_show'
  get 'gossips/index'
  get 'gossips/:id/show', to: 'gossips#show', as: 'gossips_show'
  get 'welcome/:first_name', to: 'welcome#user'
  get '/team', to: 'static#team'
  get '/contact', to: 'static#contact'
  resources :gossips, only: %i[new create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
