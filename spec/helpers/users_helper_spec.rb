require 'spec_helper'

describe UsersHelper do
  let(:user) { users(:spok) }

  describe "show_user_avatar" do
    context "when user has url_image" do
      it "should return the url_image" do
        user.url_image = "http://someurl.com/with/an_image.png"
        helper.show_user_avatar(user).should == "<img alt=\"An_image\" class=\"avatar icon\" src=\"http://someurl.com/with/an_image.png\" title=\"Spok\" />"
      end
    end

    context "when user has not url_image" do
      it "should return the gravatar url" do
        helper.show_user_avatar(user).should == "<img alt=\"67f5a867ebf8980611ea483756290801?s=30\" class=\"avatar icon\" src=\"http://gravatar.com/avatar/67f5a867ebf8980611ea483756290801?s=30\" title=\"Spok\" />"
      end
    end
  end
end
