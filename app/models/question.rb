class Question < ActiveRecord::Base
 validates :body, presence: true 
 belongs_to :user
 belongs_to :event
 acts_as_votable
end
