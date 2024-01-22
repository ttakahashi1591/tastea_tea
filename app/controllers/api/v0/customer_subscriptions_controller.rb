class Api::V0::CustomerSubscriptionsController < ApplicationController 
  before_action :find_customer
  before_action :find_subscription, only: [:create, :update]

  def index 
    customer = Customer.find(params[:customer_id])
    
    render json: CustomerSubscriptionsSerializer.new(@customer).to_json  
  end
  
  def create 
    customer = CustomerSubscription.create!(customer_subscription_params)

    render json: {message: "Successfully subscribed!"}, status: 200
  end

  def update 
    subscription =  CustomerSubscription.find_by(customer: @customer, subscription: @subscription)

    subscription.update(status: params[:status])

    if sub.status == "cancelled"
      render json: {message: "Subscription Cancelled"}
    end  
  end

  private 

  def customer_subscription_params 
    params.permit(:subscription_id, :customer_id)
  end

  def find_customer
    @customer = Customer.find(params[:customer_id])
  end

  def find_subscription
    @subscription = Subscription.find(params[:subscription_id] || params[:id])
  end
end