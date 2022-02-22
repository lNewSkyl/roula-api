class CheckoutController < ApplicationController

  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{ 
        name: product.name,
        amount: product.price,
        currency: "usd",
        quantity: 1,
         }],

        #  line_items: [{ 
        #   name: 1,
        #   amout: 1,
        #   currendy: "USD",
        #   quantity: 1
        #  },{ 
        #   name: 10,
        #   amout: 10,
        #   currendy: "USD",
        #   quantity: 1
        #   },{ 
        #     name: 100,
        #     amout: 100,
        #     currendy: "USD",
        #     quantity: 1
        #    }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    })
    respond_to do |format|
      format.js
    end
  end

end
