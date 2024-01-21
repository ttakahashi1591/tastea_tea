class Tea < ApplicationRecord
  has_many :subscription_teas 
  has_many :subscriptions, through: :subscription_teas

  enum tea_type: %w(black blended chai green herbal matcha oolong white)
end
