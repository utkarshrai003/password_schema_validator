require_relative 'schema_helper_methods'

module ActiveModel
  module Validations
    class WithSchemaValidator < EachValidator
      include SchemaHelperMethods

    end
  end
end
