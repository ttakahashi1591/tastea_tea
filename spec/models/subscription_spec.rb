require 'rails_helper'

RSpec.describe Subscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "associations" do
    it { should have_many :subscription_teas }
    it { should have_many(:teas).through(:subscription_teas) }
    it { should have_many :customer_subscriptions }
    it { should have_many(:customers).through(:customer_subscriptions) }
  end
end