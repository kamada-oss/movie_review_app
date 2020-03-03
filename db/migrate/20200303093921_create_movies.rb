class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :production
      t.time :creening_time
      t.string :genre
      t.integer :average_review
      t.string :director
      t.string :scenario_writer
      t.string :cast

      t.timestamps
    end
  end
end
