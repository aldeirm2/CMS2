class AddMacroProcessIdToCriticalProcess < ActiveRecord::Migration
  def self.up
    add_column :critical_processes, :macro_process_id, :integer
  end

  def self.down
    remove_column :critical_processes, :macro_process_id
  end
end
