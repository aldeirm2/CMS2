class Review < ActiveRecord::Base
  belongs_to :critical_process
  has_many :comments, :dependent => :destroy
end
