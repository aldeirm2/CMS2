class User < ActiveRecord::Base
  acts_as_authentic

  has_many :roles_as_reviewer, :through => :assignments, :class_name => 'Role', :source => :role, :conditions => {:review => true}
  has_many :roles_as_editor, :through => :assignments, :class_name => "Role", :source => :role, :conditions => {:edit => true}
  has_many :role_as_admin, :through => :assignments, :class_name => 'Role', :source => :role, :conditions => {:admin => true}
  has_many :assignments
  has_many :comments
  has_many :received_messages, :class_name => "Message", :foreign_key => 'to_id'
  has_many :sent_messages, :class_name => "Message", :foreign_key => 'from_id'

  # Ensure user enters a valid email when creating a new account that is unique within the system
  validates :email, :presence => true,
            :length => {:minimum => 5, :maximum => 254},
            :uniqueness => true,
            :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "Dosen't look like a real email address, please try again"}

  # Ensure a user enters a first and second name with his/her application
  validates_presence_of :second_name, :first_name

  # Method which returns the critical processes which the user in question has the ability to edit
  def cps_as_editor
    self.roles_as_editor.collect { |x| CriticalProcess.where(:cp_secondary_id => x.critical_process_id) }.flatten.uniq
  end

  # Method which returns the critical processes which the user in question has the ability to review
  def cps_as_reviewer
    self.roles_as_reviewer.collect { |x| CriticalProcess.where(:cp_secondary_id => x.critical_process_id) }.flatten.uniq
  end

  # Method that takes in a critical process as a parameter and checks to see if the user can edit it.
  def can_edit(cp)
    cps_as_editor.include?(cp)
  end

  # Method that takes in a critical process as a parameter and checks to see if the user can review it.
  def can_review(cp)
    cps_as_reviewer.include?(cp)
  end

  # Method which returns all the roles belonging to a user.
  def roles
    roles_as_editor + roles_as_reviewer + role_as_admin
  end

  # Method which checks to see if the user holds a admin role.
  def is_admin
    if self.role_as_admin.size > 0
      return true
    else
      return false
    end
  end

  #  Method which takes in a critical process as a parameter and checks to see if the user has access to it
  # i.e if he holds any roles for that particular CP.
  def has_access_to(cp)
    if can_review(cp) || can_edit(cp) || is_admin
      true
    end

  end

  # Method used to check if the user is authorized i.e holds any IVI roles within the system.
  def authorised
    if self.roles.size > 0
      true
    end
  end

  # Method which returns the full name of a user
  def name
    first_name + " " + second_name
  end

  # Method used to search for users within the database by username, taking in a search query as a parameter
  def self.search(search)
    if search
      query = "%#{search}%"
      where("username like ?", query)
    else
      scoped
    end
  end

  # Method used in the auto fill feature to return an array of users to the auto_fill method in the controller.
  def self.auto_fill(search)
    query = "%#{search}%"
    where("username like ?", query)
  end

  # Method which returns the amount of new messages received (unread) for the user.
  def new_messages_count
    new_messages = self.received_messages.where(:new_message => true)
    if new_messages
      return new_messages.size
    else
      return 0
    end
  end

  # Method used which returns all critical processes which are pending review for a particular user.
  def pending_review
    reviews = Review.where("stage != ?", "approved")
    all_cps_under_review = []
    user_cps_under_review = []

    reviews.each do |review|
      all_cps_under_review << review.critical_process
    end

    all_cps_under_review.each do |cp|
      if self.cps_as_reviewer.include?(cp)
        user_cps_under_review << cp
      end
    end

    return user_cps_under_review
  end

end
