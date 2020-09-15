class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true
      t.references :drama, foreign_key: true

      t.timestamps
    end
    add_index :books, [:user_id, :created_at]
  end
end
