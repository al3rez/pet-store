class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :role

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :password_digest
    add_index :users, :role
  end
end
