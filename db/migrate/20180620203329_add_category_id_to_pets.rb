class AddCategoryIdToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :category_id, :integer
    add_index :pets, :category_id
  end
end
