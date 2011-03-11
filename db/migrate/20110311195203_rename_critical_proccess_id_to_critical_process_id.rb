class RenameCriticalProccessIdToCriticalProcessId < ActiveRecord::Migration
  def self.up
    rename_column :authorizations, :critical_proccess_id, :critical_process_id
  end

  def self.down
    rename_column :authorizations, :critical_process_id, :critical_proccess_id
  end
end