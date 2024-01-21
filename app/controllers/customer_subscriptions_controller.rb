class Api::V0::CustomerSubscriptionsController < ApplicationController 
  def create 
    require 'pry'; binding.pry
    CustomerSubscription.create!(customer_subscription_params)

    render json: {message: "Successfully subscribed!"}, status: 200
  end

  def destroy 
    subscription = CustomerSubscription.find_by(customer_subscription_params)

    subscription.destroy
  end

  private 

  def customer_subscription_params 
    params.permit(:subscription_id, :customer_id)
  end
end