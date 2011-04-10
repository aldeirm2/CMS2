class AddColumnsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :second_name, :string
    add_column :users, :email_me, :boolean
  end

  def self.down
    remove_column :users, :email_me
    remove_column :users, :second_name
    remove_column :users, :first_name
  end
end
