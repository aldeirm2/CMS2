class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  has_many :roles_as_reviewer, :through => :assignments, :class_name => 'Role', :source => :role, :conditions => {:review => true}
  has_many :roles_as_editor, :through => :assignments, :class_name => "Role", :source => :role, :conditions => {:edit => true}
  has_many :role_as_admin, :through => :assignments, :class_name => 'Role', :source => :role, :conditions => {:admin => true}
  has_many :assignments
  has_many :comments

#  devise :database_authenticatable, :registerable,
#         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles_as_reviewer_ids, :roles_as_editor_ids, :role_as_admin_ids

  def cps_as_editor
    self.roles_as_editor.collect{ |x| CriticalProcess.where(:cp_secondary_id => x.critical_process_id) }.flatten.uniq
  end

  def cps_as_reviewer
    self.roles_as_editor.collect{ |x| CriticalProcess.where(:cp_secondary_id => x.critical_process_id) }.flatten.uniq
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
end
