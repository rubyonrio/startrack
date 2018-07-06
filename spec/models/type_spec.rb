require 'rails_helper'

describe Type do
  it { should have_many(:tasks) }
  it { should validate_presence_of(:name) }

end