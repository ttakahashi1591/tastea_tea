class AddStatusToCustomerSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :customer_subscriptions, :status, :integer, default: 0
  end
end
