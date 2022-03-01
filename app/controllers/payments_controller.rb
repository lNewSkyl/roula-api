class PaymentsController < ApplicationController
  prepend_before_action :find_user

  def successful_payment
    return unless @user
    @user.with_lock do
      if Stripe::Checkout::Session.retrieve(params["session_id"]).status == 'complete'
        @user.update(balance: @user.balance + (Stripe::Checkout::Session.retrieve(params["session_id"]).amount_total / 100).to_f)
      end
    end
    redirect_to current_user
  end

  def cancelled_payment
    render "/cancelled_payment"
  end

  private

  def find_user
    @user||=User.find_by_email(Stripe::Checkout::Session.retrieve(params["session_id"]).customer_details.email)  
  end

end
