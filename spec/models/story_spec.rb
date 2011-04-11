require 'spec_helper'

describe Story do
  let(:story) { Factory.build(:story) }

  describe 'Attributes' do
    it 'have name' do
      story.name = "Story Name"
      story.should be_valid
    end

    it 'have description' do
      story.description = "Description"
      story.should be_valid
    end

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
    it 'has many tasks'

  end
end
