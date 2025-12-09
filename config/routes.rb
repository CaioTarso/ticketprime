Rails.application.routes.draw do
  get 'dashboard/index'
  get 'orders/index'
  get 'orders/show'
  get "dashboard", to: "dashboard#index"
  devise_for :users
  root "events#index"

  resources :events

  resource :cart, only: [:show] do
    post :add
    delete :remove
    post :checkout
    post :increase
    post :decrease
  end

  resources :orders, only: [:index, :show]

  


  get "up" => "rails/health#show", as: :rails_health_check
end
