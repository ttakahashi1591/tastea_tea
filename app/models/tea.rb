class Tea < ApplicationRecord
  has_many :subscription_teas 
  has_many :subscriptions, through: :subscription_teas

  enum type: %w(black chai green herbal matcha mixed oolong white)
end
