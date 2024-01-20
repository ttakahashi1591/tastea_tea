require 'rails_helper'

describe "CustomerSubscriptions API Endpoints" do
  before(:each) do
    load_test_data
  end
  
  describe "CustomerSubcriptions Create Endpoint" do
    describe "Happy Path" do
      it "supports with creating the association between a customer and their new subscription" do
        # require 'pry'; binding.pry
        expect(@ash.subscriptions).to eq([@leafy])
        expect(@brock.subscriptions).to eq([@splashy])

        post "/api/v0/customers/#{@ash.id}/subscriptions", params: {subscription_id: @sparky.id}

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(JSON.parse(response.body)["message"]).to eq("Successfully subscribed!")

        post "/api/v1/customers/#{@brock.id}/subscriptions", params: {subscription_id: @sparky.id}

        expect(JSON.parse(response.body)["message"]).to eq("Successfully subscribed!")

        @ash = Customer.find(@ash.id)
        @brock = Customer.find(@brock.id)

        expect(@ash.subscriptions).to eq([@sparky])
        expect(@brock.subscriptions).to eq([@sparky])
      end 
    end

    describe "Sad Paths" do
      xit "does not allow a customer to subscribe to the subscription if they are already subscribed" do
        expect(@ash.subscriptions).to eq([@leafy, @splashy])

        post "/api/v1/customers/#{@ash.id}/subscriptions", params: {subscription_id: @splashy.id}

        expect(response).to_not be_successful
      end
    end
  end

  describe "CustomerSubscriptions Destroy Endpoint" do
    describe "Happy Path" do
      it "supports with destroying (unsubscribe) an association between a cusotmer and their subscription" do
        post "/api/v0/customers/#{@ash.id}/subscriptions", params: {subscription_id: @splashy.id}

        expect(@ash.subscriptions).to eq([@leafy, @splashy])

        delete "/api/v1/customers/#{@ash.id}/subscriptions", params: {subscription_id: @spalshy.id}

        expect(response).to be_successful
        expect(response.status).to eq(204)
        expect(response.body).to eq("")

        @ash = Customer.find(@ash.id)

        expect(@ash.subscriptions).to eq([@leafy])
      end
    end

    describe "Sad Paths" do

    end
  end
end