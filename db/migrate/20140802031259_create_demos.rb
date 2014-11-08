class CreateDemos < ActiveRecord::Migration
  def change
    create_table :demos do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :email
      t.integer :employees
      t.text :interest

      t.timestamps
    end
  end
end
