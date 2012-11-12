class AddPaidToRegister < ActiveRecord::Migration
  def change
    add_column :registers, :paid, :boolean, null: false, default: false
  end
end
