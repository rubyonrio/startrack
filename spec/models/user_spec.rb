require 'spec_helper'

describe User do
  let(:user) { Factory.build(:user) }

  describe 'Validates' do

    it 'should not create without name' do
      user.name = nil
      user.should_not be_valid
    end
  end

  describe 'Relationships' do

    it 'should have many comments' do
      comment_one = Factory.build(:comment, :id => 1)
      comment_two = Factory.build(:comment, :id => 2)
      user.comments << comment_one
      user.comments << comment_two
      user.comments.should have(2).items
    end

    it 'should have many projects' do
      project_one = Factory.build(:project)
      project_two = Factory.build(:project)
      user.projects << project_one
      user.projects << project_two
      user.projects.should have(2).items
    end

    it 'should have many tasks' do
      task_one = Factory.build(:task)
      task_two = Factory.build(:task)
      user.tasks << task_one
      user.tasks << task_two
      user.tasks.should have(2).items
    end
  end
end
