class Message < ActiveRecord::Base
  belongs_to :recipient, :class_name => 'User', :foreign_key => "to_id"
  belongs_to :sender, :class_name => 'User', :foreign_key => "from_id"

  def sender_name
    self.sender.username
  end
end
