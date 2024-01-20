require 'rails_helper'

describe "SubscriptionTeas API" do
  it "SubscriptionTeas Index" do
    create_list(:subscription_teas, 10)

    get '/api/v1/subscription_teas'

    expect(response).to be_successful
  end
end