require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "associations" do
    it { should have_many :subscription_teas }
    it { should have_many(:teas).through(:subscription_teas) }
    it { should have_many :customer_subscriptions }
    it { should have_many(:customers).through(:customer_subscriptions) }
  end

  describe "instance methods" do
    it "returns the status of subscription for a requsted customer" do
      load_test_data

      expect(@leafy.status(@ash)).to eq("active")
      expect(@sparky.status(@ash)).to eq("cancelled")
      expect(@fiery.status(@misty)).to eq("cancelled")
      expect(@splashy.status(@brock)).to eq("active")
      expect(@sparky.status(@may)).to eq("paused")
      expect(@sparky.status(@tsutomu)).to eq("active")
    end
  end
end