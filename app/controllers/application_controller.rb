class ApplicationController < ActionController::Base
  def successful_payment
    render "/successful_payment"
  end

  def cancelled_payment
    render "/cancelled_payment"
  end

end
