class RemoveTitleColumnToCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :title
  end
end
