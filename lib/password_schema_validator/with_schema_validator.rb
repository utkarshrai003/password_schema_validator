require_relative 'schema_helper_methods'

module ActiveModel
  module Validations
    class WithSchemaValidator < EachValidator
      include SchemaHelperMethods

      def initialize(options)
        @attributes = filter_options(options)
        validate_schema
      end

      def filter_options
        options.except(:attributes, :class)
      end

    end
  end
end
