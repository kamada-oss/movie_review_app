class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :cast, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:user_id, :created_at]
  end
end
