require 'rails_helper'

describe "Subscriptions API" do
  xit "Subscriptions Index" do
    load_test_data

    get '/api/v1/subscriptions'

    expect(response).to be_successful
  end
end