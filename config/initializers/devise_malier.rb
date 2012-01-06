## HACK - dmp - we must return an unserialized version of resource
## so copy devise's method and use a finder for resource

module Devise
  module Mailers
    module Helpers
      def initialize_from_record(record)
        record = hack_record(record)
        @scope_name = Devise::Mapping.find_scope!(record)
        @resource   = instance_variable_set("@#{devise_mapping.name}", record)
      end

      protected
      # monkey patch :D
      def hack_record(record)
        record.kind_of?(Hash) ? kmodel(record).where(:email=>record.first[1]['email']).first : record
      end

      def kmodel(record)
        record.first[0].camelize.constantize
      end
    end
  end
end
