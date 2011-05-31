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
  accepts_nested_attributes_for :key_terms, :reject_if => lambda { |a| a[:term].blank? }

  validates_presence_of :cp_title, :message => "New CP must have a title"

  # Methods called after a CP is created
  after_create :new_cp, :create_review

  # Method called after a CP is destroyed
  before_destroy :role_check

  # Method which is called every time a new critical process is created to create the 2 new roles for that new CP
  def make_roles
    logger.debug "CALLING CREATE ROLES"
    self.roles.create :name => "#{self.cp_title} Edit", :critical_process_id => self.cp_secondary_id, :edit => true, :review => false
    self.roles.create :name => "#{self.cp_title} Review", :critical_process_id => self.cp_secondary_id, :edit => false, :review => true
  end

  # Method called after a CP is created, the method creates a new review object for that CP and assigns it to a stage 1
  def create_review
    Review.create :stage => "1", :critical_process_id => self.id
  end

  # add roles to new version of a existing cp
  def add_roles
    self.roles << Role.where(:critical_process_id => self.cp_secondary_id, :edit => true)
    self.roles << Role.where(:critical_process_id => self.cp_secondary_id, :review => true)
  end

  # Set a secondary ID to all new CPs created within the system.
  def set_secondary_id
    self.update_attribute :cp_secondary_id, self.id
  end

  # Method called whenever a CP is created within the system, it checks to see if its  entirely new one or a new version
  # if its a completely new one, it will set a secondary ID and create roles for the CP. else it will add the appropriate roles
  # to the CP
  def new_cp
    if self.cp_secondary_id.blank?
      set_secondary_id
      make_roles
    else
      add_roles
    end
  end

  # Method to retrieve all key terms that are no assigned to a CP
  def unassigned_key_terms
    KeyTerm.all - self.key_terms
  end

  # method to check if a key term already belongs to a critical process.
  def has_key_term(key_term)
    self.key_terms.include?(key_term)
  end

  # Method used to return all the users which have a edit role for the CP.
  def editors
    for role in self.roles
      if role.edit
        list_of_users = role.users
      end
    end
    return list_of_users
  end

  # Method used to return all the users which have a review role for the CP.
  def reviewers
    for role in self.roles
      if role.review
        list_of_users = role.users
      end
    end
    return list_of_users
  end

  # Method called after each CP is deleted in the system, it ensures that if the CP deleted is the last remaining version
  # of a CP, then it should delete all roles belonging to that CP and then delete the authorization rows which held the relationships.
  def role_check
    cp_roles = self.roles
    number_of_roles = cp_roles.size

    number_of_roles.times do |i|
      if cp_roles[i - 1].critical_processes.size == 1
        cp_roles[i - 1].destroy
      end
    end
    self.authorizations.each { |x| x.destroy }
  end


  # Method which would return the latest approved version of a CP.
  def latest_approved_revision
    revisions = CriticalProcess.where(:cp_secondary_id => self.cp_secondary_id)
    revisions.sort! { |x, y| y.updated_at <=> x.updated_at }

    revisions.each do |x|
      if x.review.stage == 'approved'
        return x
      end
    end
  end

  # Method takes in a a user object as a parameter and then returns an array of unique CPs which he/she is able to view.

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

  # Method which returns the number of unique critical processes within the system
  def self.cp_count
    number_of_uniq_cps = CriticalProcess.all.uniq_by { |cp| cp.cp_secondary_id }.size
    return number_of_uniq_cps
  end

end
