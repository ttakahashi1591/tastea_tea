class RemoveStatusFromSubscriptions < ActiveRecord::Migration[7.1]
  def change
    remove_column :subscriptions, :status, :boolean
  end
end
