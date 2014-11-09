class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.integer :user_id
      t.string :encrypted_message, limit: 2048
      t.string :message_hash

      t.timestamps
    end
  end
end
