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

        post "/api/v0/customers/#{@ash.id}/subscriptions", params: {subscription_id: @leafy.id}

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        error = JSON.parse(response.body, symbolize_names: true)

        expected = {
          errors: [
            detail: "Validation failed: Customer is already subscribed!"
          ]
        }

        expect(error).to eq(expected)

        post "/api/v0/customers/#{@brock.id}/subscriptions", params: {subscription_id: @splashy.id}

        expect(response).to_not be_successful
      end

      it "will replace a cancelled subscription to an active subscription if it already exists" do
        load_test_data 

        get "/api/v0/customers/#{@ash.id}/subscriptions"

        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions.count).to eq(2)
        expect(subscriptions.second[:id]).to eq(@sparky.id.to_s)
        expect(subscriptions.second[:attributes][:status]).to eq("cancelled")

        post "/api/v0/customers/#{@ash.id}/subscriptions", params: {subscription_id: @sparky.id}

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)["message"]).to eq("Successfully subscribed!")

        get "/api/v0/customers/#{@ash.id}/subscriptions"

        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions.count).to eq(2)
        expect(subscriptions.second[:id]).to eq(@sparky.id.to_s)
        expect(subscriptions.second[:attributes][:status]).to eq("active")
      end

      it "will return an error if customer id given is invalid" do
        load_test_data

        post "/api/v0/customers/151/subscriptions", params: {subscription_id: @sparky.id}

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

      it "will return an error if subscription id given is invalid" do
        load_test_data

        post "/api/v0/customers/#{@ash.id}/subscriptions", params: {subscription_id: 151263}

        expect(response).to_not be_successful 
        expect(response.status).to eq(404)

        error = JSON.parse(response.body, symbolize_names: true)

        expected = {
          errors: [
            detail: "Couldn't find Subscription with 'id'=151263"
          ]
        }

        expect(error).to eq(expected)
      end
    end
  end

  describe "CustomerSubscriptions Update Endpoint" do
    describe "Happy Path" do
      it "supports with cancelling (unsubscribe) an association between a customer and their subscription" do
        load_test_data

        expect(@ash.subscriptions).to eq([@leafy, @sparky])

        get "/api/v0/customers/#{@ash.id}/subscriptions"

        subscriptions_1 = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions_1.first[:id]).to eq(@leafy.id.to_s)
        expect(subscriptions_1.first[:attributes][:status]).to eq("active")

        patch "/api/v0/customers/#{@ash.id}/subscriptions/#{@leafy.id}", params: {status: "cancelled"}

        message = JSON.parse(response.body, symbolize_names: true)[:message]

        expect(response.status).to eq(200)
        expect(message).to eq("Subscription cancelled")
        
        get "/api/v0/customers/#{@ash.id}/subscriptions"

        subscriptions_2 = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions_2.first[:id]).to eq(@leafy.id.to_s)
        expect(subscriptions_2.first[:attributes][:status]).to eq("cancelled")
      end

      it "supports with pausing an association between a customer and their subscription" do
        load_test_data

        get "/api/v0/customers/#{@ash.id}/subscriptions"

        subscriptions_1 = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions_1.first[:id]).to eq(@leafy.id.to_s)
        expect(subscriptions_1.first[:attributes][:status]).to eq("active")

        patch "/api/v0/customers/#{@ash.id}/subscriptions/#{@leafy.id}", params: {status: "paused"}

        expect(response).to be_successful
        expect(response.status).to eq(200)

        message = JSON.parse(response.body, symbolize_names: true)[:message]

        expect(message).to eq("Subscription paused")

        get "/api/v0/customers/#{@ash.id}/subscriptions"

        subscriptions_2 = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions_2.first[:id]).to eq(@leafy.id.to_s)
        expect(subscriptions_2.first[:attributes][:status]).to eq("paused")
      end
    end

    describe "Sad Paths" do
      it "will return an error if association does not exist" do
        load_test_data

        patch "/api/v0/customers/#{@james.id}/subscriptions/#{@sparky.id}", params: {status: "cancelled"}

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        error = JSON.parse(response.body, symbolize_names: true)

        expected = {
          errors: [
            detail: "James has no subscription to Electric Type Pack that can be updated"
          ]
        }

        expect(error).to eq(expected)
      end

      it "will return an error if the given status is not a valid status" do
        load_test_data

        patch "/api/v0/customers/#{@ash.id}/subscriptions/#{@leafy.id}", params: {status: "pikachu"}

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        error = JSON.parse(response.body, symbolize_names: true)

        expected = {
          errors: [
            detail: "'pikachu' is not a valid status"
          ]
        }

        expect(error).to eq(expected)
      end

      it "will return an error if the customer doesn't exist" do
        patch "/api/v0/customers/456789/subscriptions/7", params: {status: "cancelled"}

        expect(response).to_not be_successful 
        expect(response.status).to eq(404)

        error = JSON.parse(response.body, symbolize_names: true)

        expected = {
          errors: [
            detail: "Couldn't find Customer with 'id'=456789"
          ]
        }

        expect(error).to eq(expected)
      end

      it "will return an error if subscription doesn't exist" do
        load_test_data

        patch "/api/v0/customers/#{@ash.id}/subscriptions/2353768", params: {status: "cancelled"}

        expect(response).to_not be_successful 
        expect(response.status).to eq(404)

        error = JSON.parse(response.body, symbolize_names: true)

        expected = {
          errors: [
            detail: "Couldn't find Subscription with 'id'=2353768"
          ]
        }

        expect(error).to eq(expected)
      end
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
        expect(subscriptions.first[:id]).to eq(@leafy.id.to_s)
        expect(subscriptions.first[:attributes][:name]).to eq(@leafy.name)
        expect(subscriptions.first[:attributes][:status]).to eq("active")
        expect(subscriptions.second[:id]).to eq(@sparky.id.to_s)
        expect(subscriptions.second[:attributes][:name]).to eq(@sparky.name)
        expect(subscriptions.second[:attributes][:status]).to eq("cancelled")
      end

      it "will return an empty array if customer has no subscriptions they are subscribed to" do
        load_test_data 

        get "/api/v0/customers/#{@james.id}/subscriptions" 

        expect(response).to be_successful
        expect(response.status).to eq(200)

        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(subscriptions).to eq([])
      end
    end

    describe "Sad Paths" do   
      it "returns an error if a customer requested is not found" do
        get "/api/v0/customers/151263/subscriptions" 

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        error = JSON.parse(response.body, symbolize_names: true)

        expected = {
          errors: [
            detail: "Couldn't find Customer with 'id'=151263"
          ]
        }

        expect(error).to eq(expected)
      end
    end
  end 
end