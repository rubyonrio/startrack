require 'spec_helper'

describe Comment do
  let(:comment) { Factory.build(:comment) }

  describe "Validates" do
    it 'should require a task' do
      comment.task = nil
      comment.should_not be_valid
    end

    it 'should require an user' do
      comment.user = nil
      comment.should_not be_valid
    end
  end
end
