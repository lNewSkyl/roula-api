require 'stripe'
require 'pay'

class CheckoutsService
  def initialize(product_price, current_user)
    @current_user = current_user
    @product_price = product_price
  end

  def call
    ActiveRecord::Base.transaction do
      @current_user.set_payment_processor :stripe
      @current_user.pay_customers
      @checkout_session = @current_user.payment_processor.checkout(
        mode: "payment",
        line_items: [{ 
                name: 'Balance replenishment',
                amount: @product_price * 100,
                currency: 'usd',
                quantity: 1,
                }],
        success_url: 'http://localhost:3000/successful_payment',
        cancel_url: 'http://localhost:3000/cancelled_payment',
      )
    end
  end

end
