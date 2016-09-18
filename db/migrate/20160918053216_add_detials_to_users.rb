class AddDetialsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :birthday, :datetime
    add_column :users, :mobile, :string
    add_column :users, :address, :string
    add_column :users, :roles, :integer
  end
end
