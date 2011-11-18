namespace :heroku do
  APP = 'startrack'

  def run(*cmd)
    system(*cmd)
    raise "Command #{cmd.inspect} failed!" unless $?.success?
  end

  def confirm(message)
    print "\n#{message}\nAre you sure? [Yn] "
    raise 'Aborted' unless STDIN.gets.chomp.downcase == 'y'
  end

  def app_version
    %x[git describe --tags --abbrev=0]
  end

  desc "Deploy app to Heroku"
  task :deploy do
    puts "-----> Pushing..."
    run "git push git@heroku.com:#{APP}.git HEAD:master -f"

    puts "-----> Versioning..."
    run "heroku config:add APP_VERSION=#{app_version} --app #{APP}"

    puts "-----> Restarting..."
    run "heroku restart --app #{APP}"
  end

end
