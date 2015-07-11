class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :details
      t.references :customer, index: true

      t.timestamps null: false
    end
    add_foreign_key :accounts, :customers
  end
end
