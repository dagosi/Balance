class AddPaymentTypeToRegisters < ActiveRecord::Migration
  def change
    add_column :registers, :payment_type, :string
  end
end
