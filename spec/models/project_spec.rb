require 'spec_helper'

describe Project do
  let(:project) { Factory.build(:project) }

  describe 'Attributes' do

    it 'have a name' do
      project.name = 'StarTrack'
      project.should be_valid
    end

    it 'have a description' do
      project.description = 'An Agile Project Management'
      project.should be_valid
    end
  end

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
      user = Factory.build(:user)
      project.users << user
      project.should be_valid
    end
    
    it 'has stories'
  end
end
