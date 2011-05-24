class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :subject
      t.text :message_body
      t.integer :from_id
      t.integer :to_id
      t.boolean :new_message

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
