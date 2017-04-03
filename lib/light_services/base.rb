module LightServices
  module Base

    module ClassMethods
      def attributes(*args)
        define_class_attributes(args)
        @attributes = args
      end

      def get_attributes
        @attributes || {}
      end

      def returns(resource, &block)
        @returns = resource
        @returns_block = block if block_given?
      end

      def get_returns
        @returns || ''
      end

      def get_returns_block
        @returns_block
      end

      def execute(method_name, options = {})
        @method_name     = method_name
        @execute_options = { if: options[:if], fallback: options[:fallback] }
      end

      def get_execute_method_name
        @method_name
      end

      def get_execute_method_options
        @execute_options
      end

      def define_class_attributes(attributes)
        attributes.map do |attr_name|
          send(:attr_reader, attr_name)
        end
      end
    end

    module InstanceMethods
      def attributes
        self.class.get_attributes
      end

      def returns
        self.class.get_returns
      end

      def returns_name
        self.class.get_returns.to_s.downcase
      end

      def returns_block
        self.class.get_returns_block
      end

      def execute_method_name
        self.class.get_execute_method_name
      end

      def execute_method_options
        self.class.get_execute_method_options
      end

      def initialize_class_attributes(args)
        args[0].map do |attr_name, value|
          if attributes.include? attr_name
            instance_variable_set("@#{ attr_name }", value)
          end
        end
      end

      def initialize_returns_attribute
        instance_variable_set("@#{ returns_name }", returns)
      end

      def setup_returns
        self.instance_exec( returns, &returns_block )
      end
    end

  end
end
