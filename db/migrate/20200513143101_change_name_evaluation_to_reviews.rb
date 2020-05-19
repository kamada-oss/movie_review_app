class ChangeNameEvaluationToReviews < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :evaluation, :star
  end
end
