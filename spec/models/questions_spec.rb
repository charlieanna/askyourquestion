require "spec_helper"

describe Question do
  context "with 2 or more comments" do
    it "orders them in reverse" do
      post = Post.create
      comment1 = post.comment("first")
      comment2 = post.comment("second")
      post.reload.comments.should eq([comment2, comment1])
    end
  end
end