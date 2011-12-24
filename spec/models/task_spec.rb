require 'spec_helper'

describe Task do

  let(:task) { tasks(:create_enterprise) }

  describe "Relationships" do
    it { should belong_to(:project) }
    it { should belong_to(:user) }
    it { should belong_to(:responsible) }
    it { should belong_to(:status) }
    it { should belong_to(:type) }
    it { should belong_to(:estimate) }
    it { should have_many(:comments) }
    it { should have_and_belong_to_many(:watchers) }
  end

  describe "Validates" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:project) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:status) }
  end

  it "should show 'No responsible yet' if do not have a responsible" do
    task.show_responsible_name.should == 'No responsible yet'
  end

  it "should show a estimative with 'show_estimate_name'" do
    task.show_estimate_name.should == 'Fast'
  end


end

