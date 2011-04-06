class AddCriticalProcessesLockVersion < ActiveRecord::Migration
  def self.up
    add_column :critical_processes, :lock_version, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :critical_processes, :lock_version
  end
end
