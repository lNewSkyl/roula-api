Rails.application.routes.draw do
  resources :products
  devise_for :users, controllers: { registrations: "registrations" }
  get 'checkout', to: 'checkouts#show'

  root 'home#homepage'
  
  resources :users, only: [:index, :show]
  get "/successful_payment", to: "application#successful_payment" do
    session = Stripe::Checkout::Session.retrieve(params[:session_id])

  end
  get "/cancelled_payment", to: "application#cancelled_payment"

  namespace :api do
    namespace :v1 do
    end
  end
end
