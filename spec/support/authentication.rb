module DeviseLoginTestHelper
  def login!
    sign_in users(:spok)
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include DeviseLoginTestHelper, :type => :controller
end

shared_examples_for "authentication_required_action" do
  context "not logged in" do
    before do
      do_action 
    end
    it "should redirect to sign in" do
      should redirect_to("http://test.host/users/sign_in")
    end
  end
end