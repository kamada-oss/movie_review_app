class CreateDramaCasts < ActiveRecord::Migration[5.1]
  def change
    create_table :drama_casts do |t|
      t.string :relation
      t.references :drama, foreign_key: true
      t.references :cast, foreign_key: true

      t.timestamps
    end
  end
end
