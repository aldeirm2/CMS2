class CreateAuthorizations < ActiveRecord::Migration
  def self.up
    create_table :authorizations do |t|
      t.integer :role_id
      t.integer :critical_proccess_id

      t.timestamps
    end
  end

  def self.down
    drop_table :authorizations
  end
end
