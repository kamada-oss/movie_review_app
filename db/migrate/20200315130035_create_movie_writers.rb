class CreateMovieWriters < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_writers do |t|
      t.references :movie, foreign_key: true
      t.references :writer, foreign_key: true

      t.timestamps
    end
  end
end
