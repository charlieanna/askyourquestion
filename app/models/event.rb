class Event < ActiveRecord::Base
  has_many :users
  has_many :questions
  belongs_to :admin
  validates :code, presence: true,uniqueness: true, length: { maximum: 6,minimum: 6 }
  validates :name,presence: true 
  after_initialize :generate_code
  
  def generate_code
    self.code ||= get_unique_code if self.new_record?
  end
  
  def get_unique_code
    new_event_code = generate_event_code
    while Event.exists?(code: new_event_code)
      new_event_code = generate_event_code
    end
    return new_event_code
  end

  # Generates a random string from a set of easily readable characters
  def generate_event_code(size = 6)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map { charset.to_a[rand(charset.size)] }.join
  end
 
end
