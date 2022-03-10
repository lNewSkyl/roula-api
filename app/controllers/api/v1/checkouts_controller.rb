module Api
  module V1
    class CheckoutsController < ApplicationController
      before_action :authenticate_user!
      before_action :find_product

      # def show
      #   CheckoutsService.new(@product.price, current_user).call
      # end

      def show
        puts (checkout_url)
        ActiveRecord::Base.transaction do
          current_user.set_payment_processor :stripe
          current_user.pay_customers
          @checkout_session = current_user.payment_processor.checkout(
            mode: "payment",
            line_items: [{ 
                    name: 'Balance replenishment',
                    amount: @product.price * 100,
                    currency: 'usd',
                    quantity: 1
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

      private

      def find_product
        @product = Product.find(params[:id])
      end
    end
  end
end
