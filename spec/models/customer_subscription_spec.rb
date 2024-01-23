require 'rails_helper'

RSpec.describe CustomerSubscription, type: :model do
  describe "associations" do
    it { should belong_to :customer }
    it { should belong_to :subscription }
  end

  describe "validations" do
    describe "the association between customer and subscription already exists" do
      it "returns an error if customer subscription is already active" do
        @ash = Customer.create!(first_name: "Ash", last_name: "Ketchum", email: "ash.ketchum@example.com", street_address: "1234 Pallet Town Road", city: "Viridian", state: "Kanto", zip_code: "12345")

        @leafy = Subscription.create!(name: "Grass Type Pack", price: 15.99, frequency: "Bi-Weekly")

        CustomerSubscription.create!(customer: @ash, subscription: @leafy, status: "active")

        expect { CustomerSubscription.create!(customer: @ash, subscription: @leafy) }.to raise_error("Validation failed: Customer is already subscribed!")
      end

      it "replaces an old subscription if subscription is currently inactive" do
        @ash = Customer.create!(first_name: "Ash", last_name: "Ketchum", email: "ash.ketchum@example.com", street_address: "1234 Pallet Town Road", city: "Viridian", state: "Kanto", zip_code: "12345")
        
        @leafy = Subscription.create!(name: "Grass Type Pack", price: 15.99, frequency: "Bi-Weekly")

        CustomerSubscription.create!(customer: @ash, subscription: @leafy, status: "cancelled")

        expect(CustomerSubscription.count).to eq(1)
        expect(CustomerSubscription.last.status).to eq("cancelled")

        CustomerSubscription.create!(customer: @ash, subscription: @leafy)

        expect(CustomerSubscription.count).to eq(1)
        expect(CustomerSubscription.last.status).to eq("active")
      end
    end
  end
end