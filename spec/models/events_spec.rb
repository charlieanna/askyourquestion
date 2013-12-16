require 'spec_helper'

describe Event do
  it { should respond_to(:name) }
  it { should respond_to(:code) }
  it { should have_many(:users) }
  it { should have_many(:questions) }
  it { should validate_uniqueness_of(:code) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:admin) }
  
  describe "event is created" do
    it "generates a code" do
      event = Event.new
      event.name = "Oracle"
      event.save
      expect(event.code).to_not be_nil
    end 
    
    it "with a unique code" do
      event = Event.new
      event.name = "Oracle"
      event.save
      event.code = "ABCDEF"
      event.save
      
      event1 = Event.new
      event1.name = "Oracle"
      event1.save
      event1.code = "ABCDEF"
      expect(event1).to_not be_valid
      
      event2 = Event.new
      event2.name = "Oracle"
      event2.save
      expect(event2).to be_valid
    end
    
  end
  describe "when code is too long" do
    before do
      @event = Event.new
      @event.name = "Oracle"
      @event.code = "a" * 7
    end
    it "should not be valid" do
      expect(@event).to_not be_valid 
    end
  end
  
  describe "when code is too short" do
    before do
      @event = Event.new
      @event.name = "Oracle"
      @event.code = "a" * 5
    end
    it "shoud not be valid" do
      expect(@event).to_not be_valid 
    end
  end
  
  describe "Add a question to the event" do
    it "increases the questions by 1" do
      @event = Event.new
      @event.name = "Oracle"
      @event.code = "a" * 5
      @event.save
      
      question = Question.new(body: "hi?")
      @event.questions << question
    end
  end
  

end