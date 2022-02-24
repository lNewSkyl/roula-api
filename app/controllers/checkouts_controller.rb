class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product

  def show
    ActiveRecord::Base.transaction do
      user=User.find(current_user.id)
      current_user.set_payment_processor :stripe
      current_user.pay_customers
      @checkout_session = current_user.payment_processor.checkout(
        mode: "payment",
        line_items: [{ 
                name: 'Balance replenishment',
                amount: @product.price * 100,
                currency: 'usd',
                quantity: 1,
                }],
        success_url: 'http://localhost:3000/successful_payment',
        cancel_url: 'http://localhost:3000/cancelled_payment',
      )
    end
  end

  def check_session
    if @checkout_session.status == "complete"
      user.balance+=@product.price
      user.save
    end
  end

  def find_product
    @product = Product.find(params[:id])
  end

end
