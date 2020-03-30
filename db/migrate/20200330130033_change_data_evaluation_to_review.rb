class ChangeDataEvaluationToReview < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :evaluation, :float
  end
end
