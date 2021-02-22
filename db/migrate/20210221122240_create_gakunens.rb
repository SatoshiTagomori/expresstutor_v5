class CreateGakunens < ActiveRecord::Migration[5.2]
  def change
    create_table :gakunens do |t|
      t.string :name

      t.timestamps
    end
  end
end
