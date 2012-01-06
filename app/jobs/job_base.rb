class JobBase < Resque::JobWithStatus

  # Subclasses should  implement this method
  def perform_work
  end

  def perform
    redis = Redis.new(:host => 'localhost', :port => 6379)

    unless redis.get("bot_startrack:#{name}").nil?
      puts redis.get("bot_startrack:#{name}").inspect

      puts "*** #{name} is already being executed"
      return
    end

    puts "Running #{name}"

    redis.setex("bot_startrack:#{name}", 60*60*3,'true') # Key expires in 3 hours...

    begin
      perform_work
    rescue Exception => e
      failed(e.message)
      raise e
    else
      failed("Unknown exception")
    ensure
      redis.del("bot_startrack:#{name}")
      puts " Ended #{name}"
    end
  end

  def name
    self.class.to_s.gsub('Job', '')
  end
end
