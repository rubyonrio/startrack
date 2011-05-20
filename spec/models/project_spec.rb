require 'spec_helper'

describe Project do
  let(:project) { Factory.build(:project) }

  describe 'Validates' do
    it 'should not create without name' do
      project.name = nil
      project.should_not be_valid
    end
  end

  describe 'Relationships' do
    it 'should have many users' do
      user_one = Factory.build(:user)
      user_two = Factory.build(:user)
      project.users << user_one
      project.users << user_two
      project.users.should have(2).items
    end

    it 'should have many tasks' do
      task_one = Factory.build(:task)
      task_two = Factory.build(:task)
      project.tasks << task_one
      project.tasks << task_two
      project.tasks.should have(2).items
    end
  end
end
