class CreatePersonals < ActiveRecord::Migration[5.2]
  def change
    create_table :personals do |t|
      t.references :student, foreign_key: true
      t.references :pref, foreign_key: true
      t.references :gakunen, foreign_key: true
      t.string :name
      t.string :cname
      t.string :tel
      t.string :email

      t.timestamps
    end
  end
end
