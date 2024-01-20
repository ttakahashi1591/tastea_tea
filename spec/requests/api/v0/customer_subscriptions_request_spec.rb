require 'rails_helper'

describe "CustomerSubscriptions API" do
  it "CustomerSubscriptions Index" do
    create_list(:customer_subscription, 10)

    get '/api/v1/customer_subscriptions'

    expect(response).to be_successful
  end
end