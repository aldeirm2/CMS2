class Authorization < ActiveRecord::Base
  belongs_to :critical_process
  belongs_to :role
end
