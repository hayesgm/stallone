class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :auth_token
      t.string :phone_number
      t.string :uuid
      t.text :public_key
      t.text :private_key

      t.timestamps
    end
    add_index :users, :auth_token, unique: true
    add_index :users, :phone_number, unique: true
    add_index :users, :uuid, unique: true
  end
end
