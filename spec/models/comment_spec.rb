require 'spec_helper'

describe Comment do
  it { should belong_to(:task) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:task) }
  it { should validate_presence_of(:user) }
  
  describe "to_format" do
    let(:comment) { Factory.build(:comment) }

    it "should call to_format before save" do
      comment.save
      comment.description.should == "<p>I got some money to help you out with this issue!</p>"
    end
  end
end