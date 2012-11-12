class CreateRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|
      t.references :user
      t.date :date
      t.string :description
      t.integer :amount
      t.string :type

      t.timestamps
    end
  end
end
