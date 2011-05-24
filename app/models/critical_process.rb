class CriticalProcess < ActiveRecord::Base
  belongs_to :macro_process
  has_many :categories, :dependent => :destroy
  has_many :lessons, :dependent => :destroy
  has_many :authorizations
  has_many :roles, :through => :authorizations
  has_and_belongs_to_many :key_terms
  has_one :review, :dependent => :destroy
  accepts_nested_attributes_for :categories, :reject_if => lambda { |a| a[:category_title].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :lessons, :reject_if => lambda { |a| a[:lesson_title].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :key_terms, :reject_if => lambda {|a| a[:term].blank? }

  after_create :new_cp, :create_review

  before_destroy :role_check

  #scope :approved, :conditions => { :review.stage => 'approved'}

   #method which is called everything a new critical process is created to create the 2 new roles for that new CP
  def make_roles
    logger.error "CALLING CREATE ROLES"
    self.roles.create :name => "#{self.cp_title} Edit", :critical_process_id => self.cp_secondary_id, :edit => true, :review => false
    self.roles.create :name => "#{self.cp_title} Review",:critical_process_id => self.cp_secondary_id, :edit => false, :review => true
  end

  def create_review
    Review.create :stage => "1", :critical_process_id => self.id
  end

  def add_roles
    #add roles to new version of a cp
    self.roles << Role.where(:critical_process_id => self.cp_secondary_id, :edit => true)
    self.roles << Role.where(:critical_process_id => self.cp_secondary_id, :review => true)
  end

  def set_secondary_id
      self.update_attribute :cp_secondary_id, self.id
  end

  def new_cp
    if self.cp_secondary_id.blank?
      set_secondary_id
      make_roles
    else
      add_roles
    end
  end

  # method to retrieve all key terms that are no assigned to a CP
  def unassigned_key_terms
    KeyTerm.find(:all) - self.key_terms
  end

  # method to check if a key term already belongs to a critical process.
  def has_key_term(key_term)
    self.key_terms.include?(key_term)
  end

  def editors
    for role in self.roles
      if role.edit
         list_of_users = role.users
      end
    end
    return list_of_users
  end

  def reviewers
    for role in self.roles
      if role.review
         list_of_users = role.users
      end
    end
    return list_of_users
  end

  def role_check
    cp_roles = self.roles
    number_of_roles = cp_roles.size

    number_of_roles.times do |i|
      if cp_roles[i - 1].critical_processes.size == 1
        cp_roles[i - 1].destroy
      end
    end
    self.authorizations.each {|x| x.destroy}
  end

  def latest_approved_revision
    revisions = CriticalProcess.where(:cp_secondary_id => self.cp_secondary_id)
    revisions.sort! {|x,y| y.updated_at <=> x.updated_at }
    revisions.each do |x|
      if x.review.stage == 'approved'
        return x
      end
    end
  end

  def self.authorized_critical_processes(user)
    critical_processes = []
    CriticalProcess.all.uniq_by { |x| x.cp_secondary_id }.each do |x|
      cps = CriticalProcess.where(:cp_secondary_id => x.cp_secondary_id)
      if user.has_access_to(cps.first) || user.is_admin
        cps = cps.sort { |x, y| y.updated_at <=> x.updated_at }
      else
        cps = cps.select { |x| x.review.stage == 'approved' if x.review && x.review.stage }
        cps = cps.sort { |x, y| y.updated_at <=> x.updated_at }
      end
      critical_processes << cps.first unless cps.blank?
    end

    return critical_processes
  end

end
