class Role < ActiveRecord::Base
  has_many :authorizations
  has_many :critical_processes, :through => :authorizations, :primary_key => :cp_secondary_id
  has_many :assignments
  has_many :users, :through => :assignments

end
