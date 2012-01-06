# If you have a variety of mailers in your application
# and want all of them to use Resque::Mailer by default,
# you can subclass ActionMailer::Base and have your other
# mailers inherit from an AsyncMailer:
# class AsyncMailer < ActionMailer::Base
#   include Resque::Mailer
# end


# You don't want to be sending actual emails in the test
# environment, so you can configure the environments that
# should be excluded like so:
Resque::Mailer.excluded_environments = [:test]

# If you want to set a different default queue name for your
# mailer, you can change the default_queue_name # property like so:
# Resque::Mailer.default_queue_name = 'mailer'
