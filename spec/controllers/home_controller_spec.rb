require 'spec_helper'

describe HomeController do

  describe "the signup process", :type => :request do
    before :each do
      User.create(:email => 'user@example.com', :password => 'password')
    end

    it "signs me in" do
      visit('/')
        fill_in 'user_email', :with => 'user@example.com'
        fill_in 'user_password', :with => 'password'

      click_on 'Sign in'
    end
  end

end
