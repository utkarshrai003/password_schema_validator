require_relative 'schema_helper_methods'

module ActiveModel
  module Validations
    class WithSchemaValidator < EachValidator
      include SchemaHelperMethods

      def initialize(options)
        @attributes = filter_options(options)
        validate_schema
      end

      def validate_each(record, attr_name, value)
        match_against_schema(record, attr_name, value)
      end

      def filter_options(options)
        options.except(:attributes, :class)
      end

    end
  end
end
