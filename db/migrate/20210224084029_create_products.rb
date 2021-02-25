class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :prod_id
      t.string :price_id
      t.boolean :mode
      t.integer :ticket

      t.timestamps
    end
  end
end
