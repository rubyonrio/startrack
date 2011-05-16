require 'spec_helper'

describe Project do
  let(:project) { Factory.build(:project) }

  describe 'Validates' do
    it 'should not create without name' do
      project.name = nil
      project.should_not be_valid
    end

    it 'should create with all requirements' do
      project.should be_valid
    end
  end

  describe 'Relationships' do

    it 'has users' do
      user_one = Factory.build(:user)
      user_two = Factory.build(:user)
      project.users << user_one
      project.users << user_two
      project.users.length.should eql(2)
      project.should be_valid
    end

    it 'has tasks' do
      task_one = Factory.build(:task)
      task_two = Factory.build(:task)
      project.tasks << task_one
      project.tasks << task_two
      project.tasks.length.should eql(2)
      project.should be_valid
    end
  end
end
