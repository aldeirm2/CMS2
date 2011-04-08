class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.integer :phone_number
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :login_count, :null => false, :default => 0
      t.datetime :last_login_at
      t.string :last_login_ip


      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
