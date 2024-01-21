require 'rails_helper'

describe "CustomerSubscriptions API Endpoints" do
  describe "CustomerSubcriptions Create Endpoint" do
    describe "Happy Path" do
      it "supports with creating the association between a customer and their new subscription" do
        load_test_data

        expect(@ash.subscriptions).to eq([@leafy])

        post "/api/v0/customers/#{@ash.id}/subscriptions", params: { subscription_id: @sparky.id }

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)["message"]).to eq("Successfully subscribed!")

        @ash = Customer.find(@ash.id)
      
        expect(@ash.subscriptions).to eq([@leafy, @sparky])
      end 
    end

    describe "Sad Paths" do
      it "does not allow a customer to subscribe to the subscription if they are already subscribed" do
        load_test_data

        expect(@ash.subscriptions).to eq([@leafy])

        post "/api/v1/customers/#{@ash.id}/subscriptions", params: {subscription_id: @leafy.id}

        expect(response).to_not be_successful
      end
    end
  end

  describe "CustomerSubscriptions Destroy Endpoint" do
    describe "Happy Path" do
      it "supports with destroying (unsubscribe) an association between a cusotmer and their subscription" do
        load_test_data
        
        delete "/api/v0/customers/#{@ash.id}/subscriptions", params: {subscription_id: @leafy.id}

        expect(response).to be_successful
        expect(response.status).to eq(204)
        expect(response.body).to eq("")
        
        @ash = Customer.find(@ash.id)

        expect(@ash.subscriptions).to eq([])
      end
    end

    describe "Sad Paths" do

    end
  end
end