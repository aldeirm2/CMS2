class RemoveCriticalProcessIdFromRole < ActiveRecord::Migration
  def self.up
    remove_column :roles, :critical_process_id
  end

  def self.down
    add_column :roles, :critical_process_id, :integer
  end
end
