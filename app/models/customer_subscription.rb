class CustomerSubscription < ApplicationRecord
  belongs_to :customer_id
  belongs_to :subscription_id
end
