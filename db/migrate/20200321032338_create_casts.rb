class CreateCasts < ActiveRecord::Migration[5.1]
  def change
    create_table :casts do |t|
      t.string :name
      t.string :country
      t.string :hometown
      t.string :picture

      t.timestamps
    end
  end
end
