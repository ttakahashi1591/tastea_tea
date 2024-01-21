require 'rails_helper'

describe "Teas API" do
  xit "Teas Index" do
    load_test_data

    get '/api/v1/teas'

    expect(response).to be_successful
  end
end