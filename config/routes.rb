Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root "home#homepage"
  get 'homepage', to: 'home#homepage'
  get 'dashboard', to: 'home#dashboard'
end
