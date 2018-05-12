require 'rails_helper'

describe Comment do
  it { should belong_to(:task) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:task) }
  it { should validate_presence_of(:user) }

  describe "to_format" do
    let(:comment) { Factory.build(:comment) }

    it "should call to_format before save" do
      comment = Comment.new
      comment.description = "I got some new issue to resolve!"
      comment.user = User.find_by_name("Leonard McCoy")
      comment.task = Task.find_by_name("Room the galaxy")
      comment.save
      expect(comment.description).to eq("<p>I got some new issue to resolve!</p>")
    end
  end
end
