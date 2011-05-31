class Message < ActiveRecord::Base

  belongs_to :recipient, :class_name => 'User', :foreign_key => "to_id"
  belongs_to :sender, :class_name => 'User', :foreign_key => "from_id"

  # Ensure message has a subject
  validates_presence_of :subject, :message => 'Message must have a subject'

  # Ensure message has a body
  validates_presence_of :message_body, :message => 'Message must have content in its body'

  # Method user to retrieve the senders username
  def sender_name
    self.sender.username
  end
end
