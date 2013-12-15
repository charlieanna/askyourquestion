require 'spec_helper'

describe Question do
  it { should respond_to(:body) }
  it { should respond_to(:votes) }
  it { should respond_to(:approved) }
  
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
end