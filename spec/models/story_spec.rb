require 'spec_helper'

describe Story do
  let(:story) { Factory.build(:story) }

  describe 'Attributes' do
    it 'shoud have estimate using the sum to yours tasks' 
  end

  describe 'Validation' do
    it 'should not create without name' do
      story.name = nil
      story.should_not be_valid
    end
  end

  describe 'Relationships' do

    it 'belongs to a project' do
      project = Factory.build(:project)
      story.project = project
      story.should be_valid
    end

    it 'has many tasks' do
      task_one = Factory.build(:task)
      task_two = Factory.build(:task)
      story.tasks << task_one
      story.tasks << task_two
      story.tasks.length.should eql(2)
      story.should be_valid
    end
  end
end
