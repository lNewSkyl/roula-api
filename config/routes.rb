Rails.application.routes.draw do
  resources :products
  devise_for :users, controllers: { registrations: "registrations" }
  get 'checkout', to: 'checkouts#show'

  root 'home#homepage'
  get 'homepage', to: 'home#homepage'
  
  resources :users do
  end
  get "/successful_payment", to: "application#successful_payment"
  get "/cancelled_payment", to: "application#cancelled_payment"

  namespace :api do
    namespace :v1 do
    end
  end
end
