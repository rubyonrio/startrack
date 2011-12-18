require 'spec_helper'

describe ProjectsController do
  describe "GET index" do
    it_should_behave_like "authentication_required_action"
    let(:project) { projects(:first_journey) }

    def do_action
      get(:index)
    end

    context "authenticated" do
      before(:each) do
        login!
        do_action
      end

      it { assigns(:projects).should == [project] }
      it { should respond_with(:success) }
      it { should render_template(:index) }
    end
  end
end
