class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  #Esnure that a comment has some text and is not blank
  validates_presence_of :comment

end
