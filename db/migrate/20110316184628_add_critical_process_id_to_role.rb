class AddCriticalProcessIdToRole < ActiveRecord::Migration
  def self.up
    add_column :roles, :critical_process_id, :integer
  end

  def self.down
    remove_column :roles, :critical_process_id
  end
end
