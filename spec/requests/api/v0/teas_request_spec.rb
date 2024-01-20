require 'rails_helper'

describe "Teas API" do
  it "Teas Index" do
    create_list(:tea, 10)

    get '/api/v1/teas'

    expect(response).to be_successful
  end
end