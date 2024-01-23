require 'rails_helper'

describe "Customers API" do
  xit "Customers Index" do
    load_test_data

    get '/api/v1/customers'

    expect(response).to be_successful
  end
end