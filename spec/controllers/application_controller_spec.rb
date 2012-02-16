require 'spec_helper'

describe ApplicationController do
  controller do
    def after_sign_in_path_for(resource)
      super resource
    end
  end

  describe "After sigin-in" do
    context "resource is an User" do
      let(:user) { users(:spok) }

      it "redirects to projects_url" do
        controller.after_sign_in_path_for(user).should == projects_url
      end
    end

    # TODO: I should confirme, why test if the resource is User
    context "resource is not an User" do
      let(:task) { tasks(:create_enterprise) }
      it "redirects to root_url" do
        controller.after_sign_in_path_for(task).should == root_url
      end
    end
  end
end
