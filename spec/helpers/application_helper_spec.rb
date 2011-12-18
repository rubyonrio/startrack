require 'spec_helper'

describe ApplicationHelper do

  describe "flash_messages" do
    context "when there is flash message" do
      it "should return formated the messages" do
        flash[:notice] = "Hello Crew"
        helper.flash_messages.should == "<p class=\"flash_messages\" id=\"notice\">Hello Crew</p>"  
      end      
    end

    context "when there is not flash message" do
      it "should return nothing" do
        helper.flash_messages.should == ""        
      end
    end
  end

  describe "app_version" do
    context "when there is APP_VERSION" do
      it "should return the last tag version" do
        ENV['APP_VERSION'] = "0.0.0"
        helper.app_version.should == "0.0.0"
      end      
    end

    context "when there is no APP_VERSION" do
      it "should return empty" do
        ENV['APP_VERSION'] = ""
        helper.app_version.should == ""
      end      
    end
  end
end
