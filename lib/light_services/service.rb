require 'active_model'

module LightServices
  class Service
    include ActiveModel::Validations
    include LightServices::Base::InstanceMethods
    extend  LightServices::Base::ClassMethods

    alias :input_valid? :valid?

    def initialize(*args)
      validate_arguments(args)
      initialize_class_attributes(args)
      initialize_returns_attribute
      setup_returns if returns_block
    end

    def call
      if has_conditional?
        validate_conditional
      else
        send( execute_method_name )
      end
      
      instance_variable_get("@#{ returns_name }")
    end

    private

      def has_conditional?
        !execute_method_options[:if].nil? && !execute_method_options[:if].empty?
      end

      def validate_conditional
        conditional_pass = send( execute_method_options[:if] )
        
        if conditional_pass
          send( execute_method_name )
        else
          send( execute_method_options[:fallback] ) if execute_method_options[:fallback]
        end
      end

      def validate_arguments(args)
        raise InvalidArgumentError, "Arguments required, but was given a #{args.class}" if args.empty?
        raise InvalidArgumentError, "keyword arguments are required" if args[0].class != Hash
      end

  end
end
