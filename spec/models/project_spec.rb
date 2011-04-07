require 'spec_helper'

describe Project do
  let(:project) { Factory.build(:project) }
  
  describe 'Validates' do
    it 'should not create a project without name' do
      project.name=nil
      project.valid?.should == false
    end
    
  end
end
