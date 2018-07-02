require 'rails_helper'

describe UsersHelper do
  let(:user) { create(:user, name: 'Spok') }
  let(:url_image) {"http://someurl.com/with/an_image.png"}

  describe "show_user_avatar" do
    context "when user has url_image" do
      it "should return the url_image" do
        user.url_image = url_image
        expect(helper.show_user_avatar(user)).to eq("<img title=\"#{user.name}\" class=\"avatar icon\" src=\"#{url_image}\" alt=\"An image\" />")
      end
    end

    context "when user has not url_image" do
      it "should return the gravatar url" do
        gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
        expect(helper.show_user_avatar(user)).to eq("<img title=\"#{user.name}\" class=\"avatar icon\" src=\"http://gravatar.com/avatar/#{gravatar_id}?s=30\" alt=\"#{gravatar_id}?s=30\" />")
      end
    end
  end
end
