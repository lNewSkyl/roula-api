Rails.application.routes.draw do
  resources :products
  devise_for :users, controllers: { registrations: "registrations" }

  namespace :api do
    namespace :v1 do
    end
  end

  root "home#homepage"
  get 'homepage', to: 'home#homepage'
  get 'dashboard', to: 'home#dashboard'
  
  resources :users do
  end
end
