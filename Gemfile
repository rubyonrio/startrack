source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'
gem 'devise'
gem 'mysql2'
gem 'sass'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
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

group :production do
  gem 'therubyracer'
end
