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
      xit "does not allow a customer to subscribe to the subscription if they are already subscribed" do
        load_test_data

        expect(@ash.subscriptions).to eq([@leafy, @sparky])
        expect(@brock.subscriptions).to eq([@splashy])

        post "/api/v0/customers/#{@ash.id}/subscriptions", params: {subscription_id: @leafy.id}

        expect(response).to_not be_successful

        post "/api/v1/customers/#{@brock.id}/subscriptions", params: {subscription_id: @splashy.id}

        expect(response).to_not be_successful
      end
    end
  end

  describe "CustomerSubscriptions Update Endpoint" do
    describe "Happy Path" do
      it "supports with cancelling (unsubscribe) an association between a cusotmer and their subscription" do
        load_test_data

        expect(@ash.subscriptions).to eq([@leafy, @sparky])

        get "/api/v0/customers/#{@ash.id}/subscriptions"

        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions.first[:id]).to eq(@leafy.id)
        expect(subscriptions.first[:attributes][:status]).to eq("active")

        patch "/api/v0/customers/#{@ash.id}/subscriptions/#{@leafy.id}", params: {status: "cancelled"}

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.body).to eq("Subscription Cancelled")
        
        get "/api/v0/customers/#{@ash.id}/subscriptions"

        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions.first[:id]).to eq(@leafy.id)
        expect(subscriptions.first[:attributes][:status]).to eq("cancelled")
      end
    end

    describe "Sad Paths" do

    end
  end

  describe "CustomerSubcriptions Index Endpoint" do
    describe "Happy Path" do
      it "will return a list of all customer's subscriptions no matter what status" do
        load_test_data 

        get "/api/v0/customers/#{@ash.id}/subscriptions" 

        expect(response).to be_successful
        expect(response.status).to eq(200)

        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions).to be_an(Array)
        expect(subscriptions.count).to eq(2)
        expect(subscriptions.first[:id]).to eq(@leafy.id)
        expect(subscriptions.first[:attributes][:name]).to eq(@leafy.name)
        expect(subscriptions.first[:attributes][:status]).to eq("active")
        expect(subscriptions.second[:id]).to eq(@sparky.id)
        expect(subscriptions.second[:attributes][:name]).to eq(@sparky.name)
        expect(subscriptions.second[:attributes][:status]).to eq("cancelled")
      end

      xit "will return an empty array if customer has no subscriptions they are subscribed to" do
        load_test_data 

        get "/api/v0/customers/#{@james.id}/subscriptions" 

        expect(response).to be_successful
        expect(response.status).to eq(200)

        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions).to eq([])
      end
    end

    describe "Sad Paths" do   
      xit "returns an error if a customer requested is not found" do
        get "/api/v0/customers/151/subscriptions" 

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        error = JSON.parse(response.body, symbolize_names: true)

        expected = {
          errors: [
            detail: "Couldn't find Customer with 'id'=151"
          ]
        }

        expect(error).to eq(expected)
      end
    end
  end
 
end