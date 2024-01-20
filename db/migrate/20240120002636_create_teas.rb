class CreateTeas < ActiveRecord::Migration[7.1]
  def change
    create_table :teas do |t|
      t.string :name
      t.integer :type
      t.string :description
      t.integer :temperature
      t.integer :brew_time

      t.timestamps
    end
  end
end
