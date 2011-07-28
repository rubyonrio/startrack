source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'
gem 'devise'
gem 'mysql2'
gem 'sass'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'sprockets', '2.0.0.beta.10'
gem 'RedCloth'

group :development,:test do
  platforms :mri_18 do
    gem "ruby-debug"
  end
  platforms :mri_19 do
    gem "ruby-debug19", :require => 'ruby-debug'
  end

  gem 'capybara'
  gem 'launchy'
  gem "simplecov", "~> 0.4.2"
  gem 'turn', :require => false
end
