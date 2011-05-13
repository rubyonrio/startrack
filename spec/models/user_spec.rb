require 'spec_helper'

describe User do
  let(:user) { Factory.build(:user) }

  describe 'Validates' do

    it 'should not create without name' do
      user.name = nil
      user.should_not be_valid
    end

    it 'should create with all requirements' do
      user.should be_valid
    end
  end

  describe 'Relationships' do

    it 'have projects' do
      project = Factory.build(:project)
      user.projects << project
      user.should be_valid
    end
  end
end
