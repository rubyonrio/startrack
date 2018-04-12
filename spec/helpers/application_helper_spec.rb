require 'rails_helper'

describe ApplicationHelper do
  describe '#link_to_logout' do
    it 'should return logout button' do
      expect(link_to_logout).to eq(link_to('Logout', destroy_user_session_path, method: :delete))
    end
  end

  describe "flash_messages" do
    context "when there is flash message" do
      it "should return formated the messages" do
        flash[:notice] = "Hello Crew"
        expect(helper.flash_messages).to eq("<p id=\"notice\" class=\"flash_messages\">Hello Crew</p>")
      end
    end

    context "when there is not flash message" do
      it "should return nothing" do
        expect(helper.flash_messages).to eq('')
      end
    end
  end

  describe "app_version" do
    context "when there is APP_VERSION" do
      it "should return the last tag version" do
        ENV['APP_VERSION'] = "0.0.0"
        expect(helper.app_version).to eq('0.0.0')
      end
    end

    context "when there is no APP_VERSION" do
      it "should return empty" do
        ENV['APP_VERSION'] = ""
        expect(helper.app_version).to eq('')
      end
    end
  end
end
