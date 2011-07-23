require 'spec_helper'

describe Task do
  let(:task) {Factory.build(:task)}

  describe 'Validates' do
    it 'should have a name' do
      task.name = nil
      task.should_not be_valid
    end
  end
  
  describe 'type relationship' do
    it 'shoud return "no-type" if task do not have type' do
      task.type = nil
      task.show_type_name == 'no-type'
    end
  end

  describe 'Relationships' do
    it 'should require an user' do
      task.user = nil
      task.should_not be_valid
    end

    it 'should require a project' do
      task.project = nil
      task.should_not be_valid
    end
    
    it 'should require a type' do
      task.type = nil
      task.should_not be_valid
    end
    
    it 'should require a status' do
      task.status = nil
      task.should_not be_valid
    end
    

    it 'should have many comments' do
      comment_one = Factory.build(:comment, :id => 1)
      comment_two = Factory.build(:comment, :id => 2)
      task.comments << comment_one
      task.comments << comment_two
      task.comments.should have(2).items
    end
  end
end
