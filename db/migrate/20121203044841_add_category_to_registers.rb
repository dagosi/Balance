class AddCategoryToRegisters < ActiveRecord::Migration
  def change
    add_column :registers, :category_id, :integer
  end
end
