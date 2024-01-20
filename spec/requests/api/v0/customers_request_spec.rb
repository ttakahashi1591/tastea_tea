require 'rails_helper'

describe "Customers API" do
  it "Customers Index" do
    create_list(:customer, 10)

    get '/api/v1/customers'

    expect(response).to be_successful
  end
end