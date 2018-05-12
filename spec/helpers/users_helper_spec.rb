require 'rails_helper'

describe UsersHelper do
  let(:user) { User.find_by_name("Spok") }

  describe "show_user_avatar" do
    context "when user has url_image" do
      it "should return the url_image" do
        user.url_image = "http://someurl.com/with/an_image.png"
        expect(helper.show_user_avatar(user)).to eq("<img title=\"Spok\" class=\"avatar icon\" src=\"http://someurl.com/with/an_image.png\" alt=\"An image\" />")
      end
    end

    context "when user has not url_image" do
      it "should return the gravatar url" do
        expect(helper.show_user_avatar(user)).to eq("<img title=\"Spok\" class=\"avatar icon\" src=\"http://gravatar.com/avatar/67f5a867ebf8980611ea483756290801?s=30\" alt=\"67f5a867ebf8980611ea483756290801?s=30\" />")
      end
    end
  end
end
