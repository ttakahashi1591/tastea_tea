require 'rails_helper'

describe "CustomerSubscriptions API Endpoints" do
  describe "CustomerSubcriptions Create Endpoint" do
    describe "Happy Path" do
      it "supports with creating the association between a customer and their new subscription" do
        load_test_data

        expect(@ash.subscriptions).to eq([@leafy, @sparky])
        expect(@brock.subscriptions).to eq([@splashy])

        post "/api/v0/customers/#{@ash.id}/subscriptions", params: { subscription_id: @fiery.id }

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)["message"]).to eq("Successfully subscribed!")

        @ash = Customer.find(@ash.id)
      
        expect(@ash.subscriptions).to eq([@leafy, @fiery, @sparky,])

        post "/api/v0/customers/#{@brock.id}/subscriptions", params: { subscription_id: @sparky.id }

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)["message"]).to eq("Successfully subscribed!")

        @brock = Customer.find(@brock.id)
      
        expect(@brock.subscriptions).to eq([@splashy, @sparky])
      end 
    end

    describe "Sad Paths" do
      it "does not allow a customer to subscribe to the subscription if they are already subscribed" do
        load_test_data

        expect(@ash.subscriptions).to eq([@leafy, @sparky])
        expect(@brock.subscriptions).to eq([@splashy])

        post "/api/v1/customers/#{@ash.id}/subscriptions", params: {subscription_id: @leafy.id}

        expect(response).to_not be_successful

        post "/api/v1/customers/#{@brock.id}/subscriptions", params: {subscription_id: @splashy.id}

        expect(response).to_not be_successful
      end
    end
  end

  describe "CustomerSubscriptions Destroy Endpoint" do
    describe "Happy Path" do
      it "supports with cancelling (unsubscribe) an association between a cusotmer and their subscription" do
        load_test_data

        expect(@ash.subscriptions).to eq([@leafy, @sparky])

        delete "/api/v0/customers/#{@ash.id}/subscriptions", params: {subscription_id: @leafy.id}

        expect(response).to be_successful
        expect(response.status).to eq(204)
        expect(response.body).to eq("")
        
        @ash = Customer.find(@ash.id)

        expect(@ash.subscriptions).to eq([@sparky])
      end
    end

    describe "Sad Paths" do

    end
  end

  describe "CustomerSubcriptions Index Endpoint" do
    describe "Happy Path" do
      it "returns list of all customer's subscriptions, regardless of status" do
        load_test_data 

        get "/api/v1/customers/#{@ash.id}/subscriptions" 

        expect(response).to be_successful
        expect(response.status).to eq(200)

        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions).to be_an(Array)
        expect(subscriptions.count).to eq(2)
        expect(subscriptions.first[:id]).to eq(@leafy.id)
        expect(subscriptions.first[:attributes][:name]).to eq(@leafy.name)
        expect(subscriptions.first[:attributes][:status]).to eq("Active")
        expect(subscriptions.second[:id]).to eq(@sparky.id)
        expect(subscriptions.second[:attributes][:name]).to eq(@sparky.name)
        expect(subscriptions.second[:attributes][:status]).to eq("Cancelled")
      end

      xit "will return an empty array if customer has no subscriptions they are subscribed to" do
        load_test_data 

        get "/api/v1/customers/#{@james.id}/subscriptions" 

        expect(response).to be_successful
        expect(response.status).to eq(200)

        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(subscriptions).to eq([])
      end
    end

    describe "Sad Paths" do   
      xit "returns an error if a customer requested is not found" do

      end
    end
  end
 
end