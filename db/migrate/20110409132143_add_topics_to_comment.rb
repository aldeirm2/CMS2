class AddTopicsToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :topics, :string
  end

  def self.down
    remove_column :comments, :topics
  end
end
