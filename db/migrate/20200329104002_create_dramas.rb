class CreateDramas < ActiveRecord::Migration[5.1]
  def change
    create_table :dramas do |t|
      t.string :title
      t.date :release
      t.string :production
      t.string :genre
      t.string :status
      t.string :picture

      t.timestamps
    end
  end
end
