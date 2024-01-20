class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.float :price
      t.string :frequency
      t.boolean :status

      t.timestamps
    end
  end
end
