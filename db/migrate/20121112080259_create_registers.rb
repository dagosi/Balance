class CreateRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|
      t.references :user
      t.date :date
      t.string :description
      t.integer :amount
      t.string :balance_type

      t.timestamps
    end
    add_index :registers, :user_id
  end
end
