class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription

  enum status: %w(active cancelled paused)
end
