class Tea < ApplicationRecord
  has_many :subscription_teas 
  has_many :subscriptions, through: :subscription_teas

  self.inheritance_column = :_type_disabled # Disable STI
  enum type: %w(black chai green herbal matcha mixed oolong white)
end
