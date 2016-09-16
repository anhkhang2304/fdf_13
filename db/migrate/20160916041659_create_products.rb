class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category_id
      t.float :price
      t.string :description
      t.string :avatar
      t.integer :quantity
      t.float :rate

      t.timestamps null: false
    end
  end
end
