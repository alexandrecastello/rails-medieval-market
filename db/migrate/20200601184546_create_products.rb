class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :quantity
      t.string :category
      t.integer :coin_price
      t.string :tradable_for
      t.integer :other_price
      t.integer :negotiable
      t.string :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
