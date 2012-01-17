module Resque
  module Mailer
    class ResqueMessageDecoy < MessageDecoy
      def deliver
        record = @args.first
        resque.enqueue @mailer_class, @method_name, record.class.name, record.id
      end
    end
  end
end

class DeviseResqueMailer < Devise::Mailer
  include Resque::Mailer

  def self.method_missing(method_name, *args)
    return super if environment_excluded?

    if action_methods.include?(method_name.to_s)
      ResqueMessageDecoy.new self, method_name, *args
    else
      super
    end
  end

  def self.perform(action, class_name, id)
    record = class_name.constantize.find(id)
    self.send(:new, action, record).message.deliver
  end
end