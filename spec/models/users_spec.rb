require 'spec_helper'

describe User do
  it {should_not respond_to(:likes)}
  it {should respond_to(:like)}
  
  describe "#likes" do
    it "should return false if the question is not approved" do
      b = User.new.like(Question.create(body:"Hi"))
      expect(b).to be_false
    end
    it "should return true if the question is approved" do
      b = User.new.like(Question.create(body:"Hi",approved: true))
      expect(b).to be_true
    end
  end
end