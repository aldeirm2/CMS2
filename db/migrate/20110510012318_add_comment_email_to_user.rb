class AddCommentEmailToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :comment_email, :boolean
    rename_column :users, :email_me, :cp_change_email
  end

  def self.down
    rename_column :users, :cp_change_email, :email_me
    remove_column :users, :comment_email
  end
end
