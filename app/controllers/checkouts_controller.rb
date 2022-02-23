class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  # def create
  #   product = Product.find(params[:id])
  #   @session = Stripe::Checkout::Session.create({
  #     payment_method_types: ['card'],
  #     line_items: [{ 
  #       name: 'Balance replenishment',
  #       amount: product.price * 100,
  #       currency: 'usd',
  #       quantity: 1,
  #        }],
  #     mode: 'payment',
  #     success_url: 'http://localhost:3000/',
  #     cancel_url: 'http://localhost:3000/',
  #   })
  #   redirect_to @session.url, allow_other_host: true
  # end

  def show
    current_user.set_payment_processor :stripe
    current_user.pay_customers

    @checkout_session = current_user.payment_processor.checkout(
      mode: "payment",
      line_items: ['price_1KWMigCzKz8KnFWhIO6Ts0Mr', 'price_1KWMWmCzKz8KnFWhFirPmFqg', 'price_1KWJNnCzKz8KnFWhSfS5HkM4']
    )
  end

end
