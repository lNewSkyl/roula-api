class CheckoutController < ApplicationController

  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{ 
        name: 'Balance replenishment',
        amount: product.price * 100,
        currency: 'usd',
        quantity: 1,
         }],
      mode: 'payment',
      success_url: 'http://localhost:3000/',
      cancel_url: 'http://localhost:3000/',
    })
    redirect_to @session.url, allow_other_host: true


  end

end
