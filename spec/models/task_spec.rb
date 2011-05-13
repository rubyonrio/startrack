require 'spec_helper'

describe Task do
  let(:task) {Factory.build(:task)}
  
  describe 'Relationships' do

    it 'belongs to a user' do
      user = Factory.build(:user)
      task.user = user
      task.should be_valid
    end
    it 'has many tasks'

  end

end
