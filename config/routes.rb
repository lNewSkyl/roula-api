Rails.application.routes.draw do
  resources :products
  devise_for :users,
             controllers: {
               
                #  sessions: 'sessions',
                #  registrations: 'registrations'
             }
  resources :users

  
  get 'checkout', to: 'checkouts#show'

  root 'home#homepage'
  get 'roulette', to: 'roulette#index'
  get 'roulette/solo', to: 'roulette#solo'
  get 'roulette/coop', to: 'roulette#coop'

  get "/successful_payment", to: "payments#successful_payment" do
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
  end
  
  get "/cancelled_payment", to: "payments#cancelled_payment"

  namespace :api do
    namespace :v1 do
      devise_for :users,
      controllers: {
        
          sessions: 'sessions',
          registrations: 'registrations'
      }
      resources :products
      get 'checkout', to: 'checkouts#show'

      root 'home#homepage'
      get 'roulette', to: 'roulette#index'
      get 'roulette/solo', to: 'roulette#solo'
      get 'roulette/coop', to: 'roulette#coop'
    
      get "/successful_payment", to: "application#successful_payment" do
        session = Stripe::Checkout::Session.retrieve(params[:session_id])
      end
    
      get "/cancelled_payment", to: "application#cancelled_payment"
    end
  end
  
end
