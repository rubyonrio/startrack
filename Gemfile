source :rubygems

gem 'rails', '3.1.0'
gem 'devise', '1.4.3'
gem 'mysql2', '0.3.6'
gem 'sass-rails', '3.1.0'
gem 'coffee-script', '2.2.0'
gem 'uglifier', '1.0.2'
gem 'jquery-rails', '1.0.13'
gem 'RedCloth'

group :development,:test do
  platforms :mri_18 do
    gem "ruby-debug"
  end
  platforms :mri_19 do
    gem "ruby-debug19", :require => 'ruby-debug'
  end

  gem 'capybara', '1.0.1'
  gem 'launchy', '2.0.5'
  gem "simplecov", "~> 0.4.2"
end

group :production do
  gem 'therubyracer'
end

group :production do
  gem 'pg'
  gem 'therubyracer'
end

