class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.integer :user_id
      t.datetime :date_update
      t.float :payment
      t.integer :status
      t.float :total_money

      t.timestamps null: false
    end
  end
end
