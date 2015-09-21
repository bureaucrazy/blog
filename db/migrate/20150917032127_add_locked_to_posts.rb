class AddLockedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :locked, :boolean, default: false
  end
end
