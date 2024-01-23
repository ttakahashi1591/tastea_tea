require 'rails_helper'

describe "SubscriptionTeas API" do
  xit "SubscriptionTeas Index" do
    load_test_data
    
    get '/api/v1/subscription_teas'

    expect(response).to be_successful
  end
end