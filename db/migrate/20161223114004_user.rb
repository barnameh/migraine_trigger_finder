class User < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fitbit_user_id, null: false
      t.string :token
      t.string :refresh_token
      t.integer :expires_at
      t.index :fitbit_user_id, unique: true
    end
  end
end
