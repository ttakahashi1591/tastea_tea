class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription

  validate :unique_or_inactive, on: :create

  enum status: %w(active cancelled paused)

  def unique_or_inactive
    found_customer = CustomerSubscription.find_by(customer_id: self.customer_id, subscription_id: self.subscription_id)

    if !found_customer.nil? && found_customer.status == "active"
      errors.add(:customer, "is already subscribed!")
    elsif !found_customer.nil? && found_customer.status != "active"
      found_customer.destroy
    end
  end
end
