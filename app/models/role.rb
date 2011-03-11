class Role < ActiveRecord::Base
  has_many :authorizations
  has_many :critical_processes, :through => :authorizations
  has_many :assignments
  has_many :users, :through => :assignments

end
