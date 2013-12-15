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