Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products do
    resources :orders, only: %i[create]
    post '/trade', to: "orders#trade", as: :trade
  end
  resources :users, only: %i[show]
  resources :orders, only: %i[create]
end
