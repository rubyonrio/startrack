require 'spec_helper'

describe Comment do
  it { should belong_to(:task) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:task) }
  it { should validate_presence_of(:user) }
end