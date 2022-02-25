Rails.application.routes.draw do
  # resources :products
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:index, :show]

  get 'checkout', to: 'checkouts#show'

  root 'home#homepage'
  get 'roulette', to: 'roulette#index'
  get 'roulette/solo', to: 'roulette#solo'
  get 'roulette/coop', to: 'roulette#coop'

  get "/successful_payment", to: "application#successful_payment" do
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
  end

  get "/cancelled_payment", to: "application#cancelled_payment"

  # namespace :api do
  #   namespace :v1 do
  #   end
  # end
  
end
