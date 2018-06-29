require 'rails_helper'
describe Comment do
  let(:commenter) {build(:user)}
  let(:task) {build(:task)}

  it { should belong_to(:task) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:task) }
  it { should validate_presence_of(:user) }

  describe "to_format" do

    it "format the comments to html" do
      comment = Comment.new
      comment.description = "I got some new issue to resolve!"
      comment.user = commenter
      comment.task = task
      comment.save
      expect(comment.description).to eq("<p>I got some new issue to resolve!</p>")
    end
  end
end
