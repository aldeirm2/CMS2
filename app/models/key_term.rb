class KeyTerm < ActiveRecord::Base
  has_and_belongs_to_many :critical_processes

  # Ensure that any new created key term is unique
  validates :term, :uniqueness => true,
                   :presence => true
  # Ensure that all new created key terms have a meaning.
  validates_presence_of :meaning

end
