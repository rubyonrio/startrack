module ControllerMacros
  def login_user
    @user ||= mock_model(User,:id => 1, :name => "RubyOnRio", :email => 'rubyonrio@gmail.com', :password => 'abc,123',
      :password_confirmation => 'abc,123')
    request.env['warden'] = mock(Warden, :authenticate => @user, :authenticate! => @user)
  end
end