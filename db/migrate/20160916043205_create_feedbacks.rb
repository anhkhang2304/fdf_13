class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :name
      t.string :content
      t.integer :status

      t.timestamps null: false
    end
  end
end
