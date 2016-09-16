class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.datetime :birthday
      t.string :email
      t.string :mobile
      t.string :address
      t.integer :roles
      t.string :password

      t.timestamps null: false
    end
  end
end
