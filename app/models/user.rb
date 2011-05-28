class User < ActiveRecord::Base
  acts_as_authentic

  has_many :roles_as_reviewer, :through => :assignments, :class_name => 'Role', :source => :role, :conditions => {:review => true}
  has_many :roles_as_editor, :through => :assignments, :class_name => "Role", :source => :role, :conditions => {:edit => true}
  has_many :role_as_admin, :through => :assignments, :class_name => 'Role', :source => :role, :conditions => {:admin => true}
  has_many :assignments
  has_many :comments
  has_many :received_messages, :class_name => "Message", :foreign_key => 'to_id'
  has_many :sent_messages, :class_name => "Message", :foreign_key => 'from_id'

  def cps_as_editor
    self.roles_as_editor.collect{ |x| CriticalProcess.where(:cp_secondary_id => x.critical_process_id) }.flatten.uniq
  end

  def cps_as_reviewer
    self.roles_as_reviewer.collect{ |x| CriticalProcess.where(:cp_secondary_id => x.critical_process_id) }.flatten.uniq
  end

  def can_edit(cp)
    cps_as_editor.include?(cp)
  end

  def can_review(cp)
    cps_as_reviewer.include?(cp)
  end

  def roles
      roles_as_editor + roles_as_reviewer + role_as_admin
  end

  def is_admin
    if self.role_as_admin.size > 0
      return true
    else
      return false
    end
  end

  def has_access_to(cp)
    if can_review(cp) || can_edit(cp)
      true
    end

  end

  def authorised
    if self.roles.size > 0
      true
    end
  end

  def name
    first_name + " " + second_name
  end

  def self.search(search)
    if search
      query = "%#{search}%"
      where("username like ?", query)
    else
      scoped
    end
  end

  def self.auto_fill(search)
    query = "%#{search}%"
    where("username like ?", query)
  end

  def new_messages_count
    new_messages = self.received_messages.where(:new_message => true)
    if new_messages
      return new_messages.size
    else
      return 0
    end
  end

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
