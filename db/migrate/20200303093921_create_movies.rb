class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.date :release
      t.string :production
      t.integer :screening_time
      t.string :genre
      t.string :status

      t.timestamps
    end
  end
end
