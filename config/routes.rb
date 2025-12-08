Rails.application.routes.draw do
  devise_for :users
  root "events#index"

  resources :events

  resource :cart, only: [:show] do
    post :add
    delete :remove
    post :checkout
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
