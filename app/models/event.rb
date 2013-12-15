class Event < ActiveRecord::Base
  has_many :users
  has_many :questions,through: :users
  validates :code, presence: true,uniqueness: true
  validates :name,presence: true 
end
