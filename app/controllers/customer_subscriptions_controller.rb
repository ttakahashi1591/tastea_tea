class Api::V0::CustomerSubscriptionsController < ApplicationController 
  def create 
    CustomerSubscription.create!(cust_subscription_params)

    render json: {message: "Successfully subscribed!"}, status: 200
  end

  def destroy 
    subscription = CustomerSubscription.find_by(cust_subscription_params)

    subscription.destroy
  end

  private 

  def cust_subscription_params 
    params.permit(:subscription_id, :customer_id)
  end
end