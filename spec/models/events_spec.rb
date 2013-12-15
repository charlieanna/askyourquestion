require 'spec_helper'

describe Event do
  it { should respond_to(:name) }
  it { should respond_to(:code) }
  it { should have_many(:users) }
  it { should have_many(:questions).through(:users) }
  it { should validate_uniqueness_of(:code) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:name) }
end