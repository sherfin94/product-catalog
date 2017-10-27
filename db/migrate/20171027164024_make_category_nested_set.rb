class MakeCategoryNestedSet < ActiveRecord::Migration[5.1]
  def change
    change_column :categories, :parent_id, :integer, null: true, index: true
    add_column :categories, :lft,       :integer
    add_column :categories, :rgt,       :integer
    add_column :categories, :depth,          :integer
    add_column :categories, :children_count, :integer
  end
end
