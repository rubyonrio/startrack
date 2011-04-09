require 'spec_helper'

describe User do
  let(:user) { Factory.build(:user) }

  describe 'Fields' do

    it 'have a name' do
      user.name = 'StarTrack Member'
      user.valid?.should == true
    end

    it 'have a email' do
      user.email = 'startrack@startrack.com'
      user.valid?.should == true
    end
  end

  describe 'Validates' do

    it 'should not create without name' do
      user.name = nil
      user.valid?.should == false
    end

    it 'should create with all requirements' do
      user.valid?.should == true
    end
  end

  describe 'Relationships' do

    it 'have projects' do
      project = Factory.build(:project)
      user.projects << project
      user.valid?.should == true
    end
  end
end
