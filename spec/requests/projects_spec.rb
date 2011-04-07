require 'spec_helper'

describe "Projects" do
  describe "GET /projects" do
    it "should render the root project path" do
      get projects_path
      response.status.should be(200)
    end
  end
end
