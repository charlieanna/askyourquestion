require 'spec_helper'

describe Question do
  it { should respond_to(:body) }
  it { should respond_to(:votes) }
  it { should respond_to(:approved) }
  it { should belong_to(:event) } 
  it { should belong_to(:user) }
  
  describe "when the question is created" do
    it "will be approved to false by default" do
      question = Question.new(body:"Hola?")
      expect(question.approved).to be_false
    end
  end
  
  describe "when a user likes the question when the question is approved" do
    user = User.create
    question = Question.create(body:"Hola?",approved: true)
    user.like question
    it "should increase the votes count" do
      expect(question.votes.up.count).to eq(1)
    end
  end
  
  describe "when a user likes the question when the question is not approved" do
    user = User.create
    question = Question.create(body:"Hola?",approved: false)
    user.like question
    it "should increase the votes count" do
      expect(question.votes.up.count).to eq(0)
    end
  end
  
  describe "A user should not be able to vote on a question that is in a event he hasn't joined" do
    it "does increase the like votes on the question even if the question is approved" do
      event = Event.create(name:"Oracle")
      user = User.create
      question = Question.create(body:"Hola?",approved: true)
      # event.questions << question
      user.like question
    end
  end
end