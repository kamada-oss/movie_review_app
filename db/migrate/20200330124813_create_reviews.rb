class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :evaluation
      t.text :comment
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true
      t.references :drama, foreign_key: true

      t.timestamps
    end
    add_index :reviews, [:user_id, :created_at]
  end
end
