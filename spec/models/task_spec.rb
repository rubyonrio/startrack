require 'rails_helper'

describe Task do

  let(:task) { Task.find_by_name("Create Enterprise") }

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
    expect(task.show_responsible_name).to eq('No responsible yet')
  end

  it "should show a estimative with 'show_estimate_name'" do
    expect(task.show_estimate_name).to eq('Fast')
  end

  it "should format task description with markdown" do
    task.description = '* hello world'
    expect(task.normalize_description).to eq("<ul>\n\t<li>hello world</li>\n</ul>")
  end

  it "should get watchers changes" do
    @watchers_changes = task.get_watchers_changes([User.find_by_name("Leonard McCoy").id])
    expect(@watchers_changes[:added]).to eq([User.find_by_name("Leonard McCoy").id])
    expect(@watchers_changes[:removed]).to eq([User.find_by_name("Commander Kirk").id])
  end

  it "should get tasks changes names" do
    @task_changes = task.get_changes_names({:type_id => [2, 1]})
    expect(@task_changes[:type_id].first).to eq('Bug')
    expect(@task_changes[:type_id].last).to eq('Feature')
  end

  it "should start to track minutes" do
    task.start_work
    expect(task.start_time).not_to be_nil
  end

  it "should stop to track minutes and get the duration in minutes" do
    task.start_work
    task.stop_work
    expect(task.start_time).to be_nil
    expect(task.duration_time).not_to be_nil
  end

end

