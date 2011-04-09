require 'spec_helper'

describe Project do
  let(:project) { Factory.build(:project) }

  describe 'Fields' do

    it 'should have a name' do
      project.name = 'StarTrack'
      project.valid?.should == true
    end

    it 'should have a description' do
      project.description = 'An Agile Project Management'
      project.valid?.should == true
    end
  end

  describe 'Validates' do

    it 'should not create without name' do
      project.name = nil
      project.valid?.should == false
    end

    it 'should create with all requirements' do
      project.valid?.should == true
    end
  end

  describe 'Relationships' do

    it 'has users' do
      user = Factory.build(:user)
      project.users << user
      project.valid?.should == true
    end
  end
end
