class Question < ActiveRecord::Base
 validates :body, presence: true 
 acts_as_votable
end
