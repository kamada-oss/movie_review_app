class AddColumnAgreemetToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :agreement, :boolean
  end
end
