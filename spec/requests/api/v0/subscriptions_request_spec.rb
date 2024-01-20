require 'rails_helper'

describe "Subscriptions API" do
  it "Subscriptions Index" do
    create_list(:subscription, 10)

    get '/api/v1/subscriptions'

    expect(response).to be_successful
  end
end