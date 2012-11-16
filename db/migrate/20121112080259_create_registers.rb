class CreateRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|
      t.references :user
      t.date :date
      t.string :description
      t.decimal :amount, precision: 8, scale: 2, default: 0.00
      t.string :balance_type

      t.timestamps
    end
    add_index :registers, :user_id
  end
end
