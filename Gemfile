source :rubygems

gem 'rails',            '3.1.2'
gem 'sass-rails',       '3.1.5'
gem 'jquery-rails',     '1.0.18'
gem 'coffee-script',    '2.2.0'
gem 'devise',           '1.4.7'
gem 'mysql2',           '0.3.7'
gem 'uglifier',         '1.0.3'
gem 'RedCloth',         '4.2.8'
gem 'simple_form',      '1.5.2'
gem 'dragonfly',        '0.9.5'
gem 'resque',           '1.19.0'

group :development,:test do
  gem 'turn', :require => false
  gem 'shoulda',        '2.11.3'
  gem 'launchy',        '2.0.5'
  gem "simplecov",      '0.5.3'
  gem 'minitest'
  gem 'integration', :git => 'git://github.com/rodrigopinto/integration.git'
  gem 'heroku',         '2.14.0'

  platforms :mri_18 do
    gem "ruby-debug",   '0.10.4'
  end
  platforms :mri_19 do
    gem "ruby-debug19", '0.11.6', :require => 'ruby-debug'
  end
end

group :production do
  gem 'therubyracer',   '0.9.8'
end
