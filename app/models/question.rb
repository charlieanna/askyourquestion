class Question < ActiveRecord::Base
  attr_accessor :user,:liked_by_current_user
 validates :body, presence: true 
 belongs_to :user
 belongs_to :event
 acts_as_votable
end
