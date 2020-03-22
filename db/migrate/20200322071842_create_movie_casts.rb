class CreateMovieCasts < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_casts do |t|
      t.string :relation
      t.references :movie, foreign_key: true
      t.references :cast, foreign_key: true

      t.timestamps
    end
  end
end
