class Api::V0::CustomerSubscriptionsController < ApplicationController 
  def index 
    customer = Customer.find(params[:customer_id])
    
    render json: CustomerSubscriptionsSerializer.new(customer).to_json
  end
  
  def create 
    customer = CustomerSubscription.create!(customer_subscription_params)

    render json: {message: "Successfully subscribed!"}, status: 200
  end

  def update 
    subscription =  CustomerSubscription.find_by(customer_id: params[:customer_id], subscription_id: params[:id])

    subscription.update(status: params[:status])
    
    render json: {message: "Subscription Cancelled"}
  end

  private 

  def customer_subscription_params 
    params.permit(:subscription_id, :customer_id)
  end
end